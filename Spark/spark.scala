
// DataFrame load
val flightData2015 = spark.read.option("inferSchema", "true").option("header", "true").csv("/csv/2015-summary.csv")

flightData2015.createOrReplaceTempView("flight_data_2015")


// SparkSQL
import org.apache.spark.sql.functions.desc
import org.apache.spark.sql.functions.max


val maxSql = spark.sql("""
   SELECT DEST_COUNTRY_NAME, sum(count) as destination_total
   FROM flight_data_2015
   GROUP BY DEST_COUNTRY_NAME
   ORDER BY sum(count) DESC
   LIMIT 5
   """)

flightData2015
     .groupBy("DEST_COUNTRY_NAME")
     .sum("count")
     .withColumnRenamed("sum(count)", "destination_total")
     .sort(desc("destination_total"))
     .limit(5)
     .show()


// Spark streaming
import org.apache.spark.sql.functions.{window, column, desc, col}

val staticDataFrame = spark.read.format("csv").option("inferSchema", "true").option("header", "true").load("/retail-data/by-day/*.csv")
staticDataFrame.createOrReplaceTempView("retail_data")
val staticSchema = staticDataFrame.schema

staticDataFrame
    .selectExpr(
      "CustomerId",
      "(UnitPrice * Quantity) as total_cost",
      "InvoiceDate")
    .groupBy(
      col("CustomerId"), window(col("InvoiceDate"), "2 day"))
    .sum("total_cost")
    .show(5)

val streamingDataFrame = spark.readStream.schema(staticSchema).option("maxFilesPerTrigger", 1).format("csv").option("header", "true").load("/data/retail-data/by-day/*.csv")
val purchaseByCustomerPerHour = streamingDataFrame.selectExpr("CustomerId","(UnitPrice * Quantity) as total_cost","InvoiceDate").groupBy($"CustomerId", window($"InvoiceDate", "1 day")).sum("total_cost")

purchaseByCustomerPerHour.writeStream.format("memory").queryName("customer_purchases").outputMode("complete").start()

spark.sql("""
     SELECT *
     FROM customer_purchases
     ORDER BY `sum(total_cost)` DESC
     """)
     .show(5)





val df = spark.read.format("avro").load("hdfs://localhost:9000/hotels/data/part-00000-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro")

val df = spark.read.format("csv").option("header", "true").load("hdfs://localhost:9000/hotels/data/*.csv")
val nullDf = df.filter("Latitude is null")



