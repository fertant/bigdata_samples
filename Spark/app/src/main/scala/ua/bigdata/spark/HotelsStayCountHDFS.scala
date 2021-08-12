package ua.bigdata.spark

import org.apache.spark.sql.{SaveMode, SparkSession}
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types._
import org.apache.spark.sql.expressions.Window
import org.apache.spark.sql.streaming.{OutputMode, Trigger}

object HotelsStayCountHDFS {

  def main(args: Array[String]): Unit = {
    val spark = SparkSession
      .builder
      .appName("Booking stay count")
      .getOrCreate()
    import spark.implicits._
    
    // Read hotels from Kafka
    val dfKafka = spark
     .read
     .format("kafka")
     .option("kafka.bootstrap.servers", "localhost:9094")
     .option("subscribe", "hotels")
     .load()    

    val schema = new StructType()
       .add("Id", StringType, true)
       .add("Name", StringType, true)
       .add("Country", StringType, true)
       .add("City", StringType, true)
       .add("Address", StringType, true)
       .add("Latitude", StringType, true)
       .add("Longitude", StringType, true)
       .add("avg_tmpr_c", StringType, true)
       .add("wthr_date", StringType, true)
    val hotels = dfKafka
     .selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)")
     .as[(String, String)]
     .withColumn("value", from_json(col("value"),schema))
     .select(col("value.*"))

    // Read expedia data from HDFS
    val expedia = spark.read.format("avro").load("hdfs://localhost:9000/expedia/*.avro")    

    // Data aggregation with hotels information from Kafka
    val hotelsReservation = expedia
      .withColumn("year", expr("year(srch_ci)"))
      .filter("year == 2017")
      .withColumn("duration", expr("datediff(to_date(srch_co),to_date(srch_ci))"))
      .join(hotels, hotels("Id") === expedia("hotel_id"), "inner")
      .withColumn("batch_timestamp", to_timestamp(col("date_time"), "yyyy-MM-dd HH:mm:ss"))
      .select("hotel_id", "batch_timestamp", "Name", "Country", "City", "srch_children_cnt", "srch_ci", "srch_co", "duration")
      .map(record => {
          var stayType = "erroneous_data"
          record.getInt(8) match {
            case 1 => {stayType = "short_stay"}
            case x if x > 1 && x <= 7 => {stayType = "standart_stay"}
            case x if x > 7 && x <= 14 => {stayType = "standart_extended_stay"}
            case x if x > 14 && x <= 30 => {stayType = "long_stay"}
            case _ => {stayType = "erroneous_data"}
          }
          (
            record.getLong(0),
            record.getTimestamp(1),
            record.getString(2),
            record.getString(3),
            record.getString(4),
            {record.getInt(5) > 0},
            record.getString(6),
            record.getString(7),
            record.getInt(8),
            stayType
          )
        }).toDF("hotel_id", "batch_timestamp", "Name", "Country", "City", "with_children", "srch_ci", "srch_co", "duration", "type_stay")
    
    // Count stay types.
    val windowHotel = Window.partitionBy("hotel_id").orderBy("srch_ci")
    val hotelsReservationCount = hotelsReservation
      .withColumn("row", row_number().over(windowHotel))
      .withColumn("with_children_cnt", count(when($"with_children" === true, 1)).over(windowHotel))
      .withColumn("erroneous_data_cnt", count(when($"type_stay" === "erroneous_data", 1)).over(windowHotel))
      .withColumn("short_stay_cnt", count(when($"type_stay" === "short_stay", 1)).over(windowHotel))
      .withColumn("standart_stay_cnt", count(when($"type_stay" === "standart_stay", 1)).over(windowHotel))
      .withColumn("standart_extended_stay_cnt", count(when($"type_stay" === "standart_extended_stay", 1)).over(windowHotel))
      .withColumn("long_stay_cnt", count(when($"type_stay" === "long_stay", 1)).over(windowHotel))
      .where(col("row") === 1)
      .select("hotel_id", "batch_timestamp", "Name", "Country", "City", "with_children_cnt", "erroneous_data_cnt", "short_stay_cnt", "standart_stay_cnt", "standart_extended_stay_cnt", "long_stay_cnt")
      .map(record => {
          var mostPopular = "erroneous_data"
          if (record.getLong(5) < record.getLong(6)) {
            mostPopular = "short_stay_cnt"
          } else if (record.getLong(6) < record.getLong(7)) {
            mostPopular = "standart_stay_cnt"
          } else if (record.getLong(7) < record.getLong(8)) {
            mostPopular = "standart_extended_stay_cnt"
          } else if (record.getLong(8) < record.getLong(9)) {
            mostPopular = "long_stay_cnt"
          }
          (
            record.getLong(0),
            record.getTimestamp(1),
            record.getString(2),
            record.getString(3),
            record.getString(4),
            record.getLong(5),
            record.getLong(6),
            record.getLong(7),
            record.getLong(8),
            record.getLong(9),
            record.getLong(10),
            mostPopular
          )
        }).toDF("hotel_id", "batch_timestamp", "Name", "Country", "City", "with_children_cnt", "erroneous_data_cnt", "short_stay_cnt", "standart_stay_cnt", "standart_extended_stay_cnt", "long_stay_cnt", "most_popular_stay_type")

    // Read expedia data from HDFS
    val expediaSchema = new StructType()
       .add("id", LongType, true)
       .add("date_time", StringType, true)
       .add("site_name", IntegerType, true)
       .add("posa_continent", IntegerType, true)
       .add("user_location_country", IntegerType, true)
       .add("user_location_region", IntegerType, true)
       .add("user_location_city", IntegerType, true)
       .add("orig_destination_distance", DoubleType, true)
       .add("user_id", IntegerType, true)
       .add("is_mobile", IntegerType, true)
       .add("is_package", IntegerType, true)
       .add("channel", IntegerType, true)
       .add("srch_ci", StringType, true)
       .add("srch_co", StringType, true)
       .add("srch_adults_cnt", IntegerType, true)
       .add("srch_children_cnt", IntegerType, true)
       .add("srch_rm_cnt", IntegerType, true)
       .add("srch_destination_id", IntegerType, true)
       .add("srch_destination_type_id", IntegerType, true)
       .add("hotel_id", LongType, true)
    val expediaStream = spark
      .readStream
      .schema(expediaSchema)
      .format("avro")
      .load("hdfs://localhost:9000/expedia/*.avro")   

    // Combine stream data with static DF and write to HDFS.
    expediaStream
      .filter("srch_ci is not null or srch_co is not null or date_time is not null")
      .withColumn("year", expr("year(srch_ci)"))
      .filter("year == 2017")
      .select("hotel_id")
      .join(hotelsReservationCount, "hotel_id")
      .select("hotel_id", "batch_timestamp", "Name", "Country", "City", "with_children_cnt", "erroneous_data_cnt", "short_stay_cnt", "standart_stay_cnt", "standart_extended_stay_cnt", "long_stay_cnt", "most_popular_stay_type")
      .writeStream
      .outputMode(OutputMode.Append)
      .trigger(Trigger.Once())
      .format("parquet")
      .option("checkpointLocation", "hdfs://localhost:9000/stay_by_type/checkpoint/")
      .option("path", "hdfs://localhost:9000/stay_by_type/")
      .start()
      .awaitTermination()

    spark.stop()
  }
}
