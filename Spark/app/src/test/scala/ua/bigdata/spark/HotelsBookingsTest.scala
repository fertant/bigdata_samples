package ua.bigdata.spark

import org.scalatest.funspec.AnyFunSpec
import HotelsBookings._
import org.apache.spark.sql.{SparkSession, DataFrame}
import java.sql.Timestamp

class HotelsBookingsTest extends AnyFunSpec {

  describe("Test hotels checkin count") {
    it("should properly calculate idle days") {
      implicit val spark: SparkSession = SparkSession.builder()
        .master("local[1]")
        .getOrCreate()
      import spark.implicits._

      val hotelsReservation = Seq(
        ("17179869184".toLong, "11 Cadogan Gardens", "US", "London", "2017-07-01"),
        ("17179869184".toLong, "11 Cadogan Gardens", "US", "London", "2017-08-01"),
      ).toDF("hotel_id", "Name", "Country", "City", "srch_ci")

      val expectedIdleDays = Seq(
        ("11 Cadogan Gardens", "US", "London", "2017-08-01", "2017-07-01", "31"),
      ).toDF("Name", "Country", "City", "srch_ci", "srch_ci_prev", "idle_days")

      val idleDays = idleDaysCount(spark, hotelsReservation)

      val diff = idleDays.except(expectedIdleDays)
      assert(diff.count() === 0)
    }

    it("should count proper number of checkin per hotel") {
      implicit val spark: SparkSession = SparkSession.builder()
        .master("local[1]")
        .getOrCreate()
      import spark.implicits._

      val validCheckin = Seq(
        ("17179869184".toLong, "11 Cadogan Gardens", "US", "London", "2017-08-22"),
        ("17179869184".toLong, "11 Cadogan Gardens", "US", "London", "2017-08-22"),
        ("17179869185".toLong, "12 Cadogan Gardens", "US", "Chelsea", "2017-08-23"),
      ).toDF("hotel_id", "Name", "Country", "City", "srch_ci")

      val expectedGroupCheckinCount = Seq(
        ("17179869184".toLong, "11 Cadogan Gardens", "London", 2),
        ("17179869185".toLong, "12 Cadogan Gardens", "Chelsea", 1),
      ).toDF("hotel_id", "Name", "City", "checkins")

      val groupCheckinCount = groupCheckin(spark, validCheckin, "City")

      val diff = groupCheckinCount.except(expectedGroupCheckinCount)
      assert(diff.count() === 0)
    }
  }
}
