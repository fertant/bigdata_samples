package ua.bigdata.spark

import org.apache.spark.sql.SparkSession
import ch.hsr.geohash.GeoHash
import org.apache.spark.sql.functions.{to_json, struct, col}

object HotelsCoordinates {

  def main(args: Array[String]): Unit = {
    val spark = SparkSession
      .builder
      .appName("Hotels")
      .getOrCreate()
    import spark.implicits._    
    
    val hotels = spark.read.format("csv").option("header", "true").load("hdfs://localhost:9000/hotels/*.csv")
    val weather = spark.read.format("parquet").load("hdfs://localhost:9000/weather/*/*/*/*.parquet")
    
    val hashWeather = weather
      .map(record => (
        record.getDouble(0),
        record.getDouble(1),
        record.getDouble(3),
        record.getString(4),
        GeoHash.geoHashStringWithCharacterPrecision(record.getDouble(1), record.getDouble(0), 4),
      )).toDF("lng","lat","avg_tmpr_c","wthr_date","hash")
    
    val hashHotels = hotels
      .filter("Latitude is not null")
      .filter("Longitude is not null")
      .filter(hotels("Latitude") !== "NA")
      .filter(hotels("Longitude") !== "NA")
      .map(record => (
        record.getString(0),
        record.getString(1),
        record.getString(2),
        record.getString(3),
        record.getString(4),
        record.getString(5),
        record.getString(6),
        GeoHash.geoHashStringWithCharacterPrecision(record.getString(5).toDouble, record.getString(6).toDouble, 4),
      )).toDF("Id","Name","Country","City","Address","Latitude","Longitude","hash")

    val hotelsWeather = hashWeather
                          .join(hashHotels, hashWeather("hash") === hashHotels("hash"), "inner")
                          .drop("lng")
                          .drop("lat")
                          .drop("hash")

    hotelsWeather.show(5)
    hotelsWeather
      .select(to_json(struct(col("*"))).alias("value"))
      .write
      .format("kafka")
      .option("kafka.bootstrap.servers", "localhost:9094")
      .option("topic", "hotels")
      .save()

    spark.stop()
  }
}
