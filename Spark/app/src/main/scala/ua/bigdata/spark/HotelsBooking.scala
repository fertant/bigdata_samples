package ua.bigdata.spark

import org.apache.spark.sql.{SaveMode, SparkSession, DataFrame}
import org.apache.spark.sql.functions._
import org.apache.spark.sql.types.{DateType, ArrayType, StringType, StructType}
import java.sql.Date
import java.time.{Duration, LocalDate}
import org.apache.spark.sql.expressions.Window
import org.apache.spark.sql.streaming.Trigger

object HotelsBookings {

  def main(args: Array[String]): Unit = {
    val spark = SparkSession
      .builder
      .appName("Booking")
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
    val hotels = spark.read.format("csv").option("header", "true").load("hdfs://localhost:9000/hotels/*.csv")

    // Read expedia data from HDFS
    val expedia = spark.read.format("avro").load("hdfs://localhost:9000/expedia/*.avro")    

    // Data aggregation with hotels information from Kafka
    val hotelsReservation = combineHotelsWithReservs(spark, expedia, hotels)

    // Query for idles day in the hotels.
    val idleDays = idleDaysCount(spark, hotelsReservation)
      
    idleDays.show(1000)

    val validCheckin = filterValidCheckin(spark, hotelsReservation)
 
    // Query check-ins grouped by hotel name and country.
    val groupCountryChekin = groupCheckin(spark, validCheckin, "Country")

    groupCountryChekin.show(1000)

    // Query check-ins grouped by hotel name and city.
    val groupCityChekin = groupCheckin(spark, validCheckin, "City")

    groupCityChekin.show(1000)

    Store result data in HDFS
    validCheckin.write.partitionBy("srch_ci")
      .format("avro")
      .mode(SaveMode.Overwrite)
      .save("/checkin")

    spark.stop()
  }

  /** 
   *  Combine hotels data and expedia reservs.
   *
   *  @param spark spark session.
   *  @param expedia Dataframe with reservs.
   *  @param hotels hotels DataFrame.
   *  @return DataFrame with reservation mapped with types.
   */
  def combineHotelsWithReservs(spark: SparkSession, expedia: DataFrame, hotels: DataFrame): DataFrame = {
    import spark.implicits._
    expedia
      .filter("srch_ci is not null")
      .filter("srch_co is not null")
      .join(hotels, hotels("Id") === expedia("hotel_id"), "inner")
      .orderBy(col("Name"),col("srch_ci").asc)
      .select("hotel_id", "Name", "Country", "City", "srch_ci")
  }

  /** 
   *  Combine hotels data and expedia reservs.
   *
   *  @param spark spark session.
   *  @param hotelsReservation Dataframe with reservs.
   *  @return DataFrame with reservation mapped with types.
   */
  def idleDaysCount(spark: SparkSession, hotelsReservation: DataFrame): DataFrame = {
    import spark.implicits._
    val windowSpec = Window.partitionBy("Name").orderBy("srch_ci")
    val windowSpecAgg =Window.partitionBy("Name")
    hotelsReservation
      .withColumn("srch_ci_prev", lag("srch_ci",1).over(windowSpec))
      .withColumn("srch_ci_diff", expr("datediff(to_date(srch_ci),to_date(srch_ci_prev))"))
      .filter("srch_ci_diff > 2")
      .withColumn("row", row_number.over(windowSpec))
      .withColumn("idle_days", sum(col("srch_ci_diff")).over(windowSpecAgg))
      .where(col("row") === 1)
      .select("Name", "Country", "City", "srch_ci", "srch_ci_prev", "idle_days")
      .orderBy(col("idle_days").asc)
  }

  /** 
   *  Combine hotels data and expedia reservs.
   *
   *  @param spark spark session.
   *  @param hotelsReservation Dataframe with reservs.
   *  @return DataFrame with reservation mapped with types.
   */
  def filterValidCheckin(spark: SparkSession, hotelsReservation: DataFrame): DataFrame = {
    import spark.implicits._
    val windowSpec = Window.partitionBy("Name").orderBy("srch_ci")
    hotelsReservation
      .withColumn("srch_ci_prev", lag("srch_ci",1).over(windowSpec))
      .withColumn("srch_ci_diff", expr("datediff(to_date(srch_ci),to_date(srch_ci_prev))"))
      .filter("srch_ci_diff < 2 or srch_ci_diff is null")
      .select("hotel_id", "Name", "Country", "City", "srch_ci")
  }

  /** 
   *  Combine hotels data and expedia reservs.
   *
   *  @param spark spark session.
   *  @param expedia Dataframe with reservs.
   *  @param hotels hotels DataFrame.
   *  @return DataFrame with reservation mapped with types.
   */
  def groupCheckin(spark: SparkSession, validCheckin: DataFrame, order: String): DataFrame = {
    import spark.implicits._
    val windowSpec = Window.partitionBy("Name").orderBy("srch_ci")
    val windowSpecAgg = Window.partitionBy("Name").orderBy(order)
    validCheckin
      .withColumn("row", row_number.over(windowSpec))
      .withColumn("checkins", count(col("srch_ci")).over(windowSpecAgg))
      .where(col("row") === 1)
      .select("hotel_id", "Name", order, "checkins")
      .orderBy(col("Name"), col("checkins").desc)
  }
}
