name := "Hive UDFs"

version := "1.0.0"
scalaVersion := "2.12.10"

libraryDependencies ++= Seq(
  "org.apache.hive" % "hive-exec" % "0.13.0",
  "ch.hsr" % "geohash" % "1.4.0",
)

ThisBuild / assemblyMergeStrategy := {
  case PathList("jackson-core-asl-1.9.13.jar", xs @ _*) => MergeStrategy.discard
  case _ => MergeStrategy.first
}