package ua.bigdata.spark

import org.scalatest.funspec.AnyFunSpec
import HotelsStayCountHDFS._
import org.apache.spark.sql.{SparkSession, DataFrame}
import java.sql.Timestamp

class HotelsStayCountHDFSTest extends AnyFunSpec {

  // describe("Test stay type count") {
  //   it("should prepare reservation types correctly") {
  //     implicit val spark: SparkSession = SparkSession.builder()
  //       .master("local[1]")
  //       .getOrCreate()
  //     import spark.implicits._

  //     val expedia = Seq(
  //       ("17179869184".toLong, "2015-07-17 09:32:04", "2017-08-22", "2017-08-23", 1),
  //       ("17179869184".toLong, "2015-07-17 09:32:04", "2017-08-22", "2017-08-25", 0),
  //       ("17179869184".toLong, "2015-07-17 09:32:04", "2017-08-22", "2017-08-30", 0),
  //       ("17179869184".toLong, "2015-07-17 09:32:04", "2017-08-22", "2017-09-08", 0),
  //       ("17179869184".toLong, "2015-07-17 09:32:04", "2017-08-22", "2017-08-21", 0),
  //     ).toDF("hotel_id", "date_time", "srch_ci", "srch_co", "srch_children_cnt")

  //     val hotels = Seq(
  //       ("17179869184".toLong, "Days Inn Brookings", "US", "Brookings"),
  //       ("17179869187".toLong, "Motel 6", "US", "Grayling")
  //     ).toDF("Id", "Name", "Country", "City")

  //     val expectedHotelsReservation = Seq(
  //       ("17179869184".toLong, "2015-07-17 09:32:04", "Days Inn Brookings", "US", "Brookings", true, "2017-08-22", "2017-08-23", 1, "short_stay"),
  //       ("17179869184".toLong, "2015-07-17 09:32:04", "Days Inn Brookings", "US", "Brookings", false, "2017-08-22", "2017-08-25", 3, "standart_stay"),
  //       ("17179869184".toLong, "2015-07-17 09:32:04", "Days Inn Brookings", "US", "Brookings", false, "2017-08-22", "2017-08-30", 8, "standart_extended_stay"),
  //       ("17179869184".toLong, "2015-07-17 09:32:04", "Days Inn Brookings", "US", "Brookings", false, "2017-08-22", "2017-09-08", 17, "long_stay"),
  //       ("17179869184".toLong, "2015-07-17 09:32:04", "Days Inn Brookings", "US", "Brookings", false, "2017-08-22", "2017-08-21", -1, "erroneous_data"),
  //     ).toDF("hotel_id", "batch_timestamp", "Name", "Country", "City", "with_children", "srch_ci", "srch_co", "duration", "type_stay")

  //     val hotelsReservation = hotelReservationTypes(spark, expedia, hotels)

  //     val diff = hotelsReservation.except(expectedHotelsReservation)
  //     assert(diff.count() === 0)
  //   }

  //   it("should count reservation type properly") {
  //     implicit val spark: SparkSession = SparkSession.builder()
  //       .master("local[1]")
  //       .getOrCreate()
  //     import spark.implicits._

  //     val hotelsReservation = Seq(
  //       ("17179869184".toLong, Timestamp.valueOf("2015-07-17 09:32:04"), "Days Inn Brookings", "US", "Brookings", true, "2017-08-22", "2017-08-23", 1, "short_stay"),
  //       ("17179869184".toLong, Timestamp.valueOf("2015-07-17 09:32:04"), "Days Inn Brookings", "US", "Brookings", false, "2017-08-22", "2017-08-25", 3, "standart_stay"),
  //       ("17179869184".toLong, Timestamp.valueOf("2015-07-17 09:32:04"), "Days Inn Brookings", "US", "Brookings", false, "2017-08-22", "2017-08-30", 8, "standart_extended_stay"),
  //       ("17179869184".toLong, Timestamp.valueOf("2015-07-17 09:32:04"), "Days Inn Brookings", "US", "Brookings", false, "2017-08-22", "2017-09-08", 17, "long_stay"),
  //       ("17179869184".toLong, Timestamp.valueOf("2015-07-17 09:32:04"), "Days Inn Brookings", "US", "Brookings", false, "2017-08-22", "2017-08-21", -1, "erroneous_data"),
  //     ).toDF("hotel_id", "batch_timestamp", "Name", "Country", "City", "with_children", "srch_ci", "srch_co", "duration", "type_stay")

  //     val expectedHotelsReservationCount = Seq(
  //       ("17179869184".toLong, Timestamp.valueOf("2015-07-17 09:32:04"), "Days Inn Brookings", "US", "Brookings", 1, 1, 1, 1, 1, 1, "short_stay_cnt"),
  //     ).toDF("hotel_id", "batch_timestamp", "Name", "Country", "City", "with_children_cnt", "erroneous_data_cnt", "short_stay_cnt", "standart_stay_cnt", "standart_extended_stay_cnt", "long_stay_cnt", "most_popular_stay_type")

  //     val hotelsReservationCount = reservationTypesCount(spark, hotelsReservation)

  //     val diff = hotelsReservationCount.except(expectedHotelsReservationCount)
  //     assert(diff.count() === 0)
  //   }
  // }
}
