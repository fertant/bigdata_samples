package ua.bigdata.spark

import org.apache.spark.sql.SparkSession
import org.elasticsearch.spark.sql._

object HotelsStayCountElastic {

  def main(args: Array[String]): Unit = {
    val spark = SparkSession
      .builder
      .appName("Booking stay count")
      .getOrCreate()
    import spark.implicits._
    
    val hotelsReservationCount = spark.read.format("parquet").load("hdfs://localhost:9000/stay_by_type/*.parquet")

    val elasticStream = hotelsReservationCount
      .write
      .format("org.elasticsearch.spark.sql")
      .option("checkpointLocation", "/tmp/")
      .option("es.resource", "expedia/_doc")
      .option("es.index.auto.create", "true")
      .option("es.nodes", "localhost")
      .option("es.port", "9200")
      .save()
    // hotelsReservationCount.saveToEs("expedia/_reserv")

    spark.stop()
  }
}
