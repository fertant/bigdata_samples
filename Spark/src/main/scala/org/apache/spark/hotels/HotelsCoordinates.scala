package org.apache.spark.hotels

import java.util.concurrent.TimeUnit
import org.apache.spark.sql.SparkSession


object HotelsCoordinates {

  def main(args: Array[String]): Unit = {
    val spark = SparkSession
      .builder
      .appName("HdfsTest")
      .getOrCreate()
    
    val df = spark.read.format("csv").option("header", "true").load("hdfs://localhost:9000/hotels/data/*.csv")
    val nullDf = df.filter("Latitude is null")

    nullDf.show()

    spark.stop()
  }
}
