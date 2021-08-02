package ua.bigdata.hive.geo

import org.apache.hadoop.hive.ql.exec.UDF
import ch.hsr.geohash.GeoHash

class Hash extends UDF {
  def evaluate(lat: Double, long: Double, desiredPrecision: Int): String = {
    return GeoHash.geoHashStringWithCharacterPrecision(lat, long, desiredPrecision)
  }
}