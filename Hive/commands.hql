CREATE EXTERNAL TABLE hotels (Id INT, Name STRING, Country STRING, City STRING, Address STRING, Latitude DOUBLE, Longitude DOUBLE) ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' STORED AS TEXTFILE LOCATION '/hotels';

CREATE EXTERNAL TABLE weather (lng DOUBLE, lat DOUBLE, avg_tmpr_f DOUBLE, avg_tmpr_c DOUBLE) PARTITIONED BY (wthr_date STRING) STORED AS PARQUET LOCATION '/weather';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-01') LOCATION '/weather/year=2017/month=9/day=1';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-02') LOCATION '/weather/year=2017/month=9/day=2';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-03') LOCATION '/weather/year=2017/month=9/day=3';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-04') LOCATION '/weather/year=2017/month=9/day=4';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-05') LOCATION '/weather/year=2017/month=9/day=5';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-06') LOCATION '/weather/year=2017/month=9/day=6';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-07') LOCATION '/weather/year=2017/month=9/day=7';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-08') LOCATION '/weather/year=2017/month=9/day=8';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-09') LOCATION '/weather/year=2017/month=9/day=9';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-10') LOCATION '/weather/year=2017/month=9/day=10';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-11') LOCATION '/weather/year=2017/month=9/day=11';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-12') LOCATION '/weather/year=2017/month=9/day=12';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-13') LOCATION '/weather/year=2017/month=9/day=13';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-14') LOCATION '/weather/year=2017/month=9/day=14';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-15') LOCATION '/weather/year=2017/month=9/day=15';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-16') LOCATION '/weather/year=2017/month=9/day=16';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-17') LOCATION '/weather/year=2017/month=9/day=17';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-18') LOCATION '/weather/year=2017/month=9/day=18';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-19') LOCATION '/weather/year=2017/month=9/day=19';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-20') LOCATION '/weather/year=2017/month=9/day=20';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-21') LOCATION '/weather/year=2017/month=9/day=21';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-22') LOCATION '/weather/year=2017/month=9/day=22';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-23') LOCATION '/weather/year=2017/month=9/day=23';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-24') LOCATION '/weather/year=2017/month=9/day=24';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-25') LOCATION '/weather/year=2017/month=9/day=25';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-26') LOCATION '/weather/year=2017/month=9/day=26';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-27') LOCATION '/weather/year=2017/month=9/day=27';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-28') LOCATION '/weather/year=2017/month=9/day=28';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-29') LOCATION '/weather/year=2017/month=9/day=29';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-09-30') LOCATION '/weather/year=2017/month=9/day=30';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-01') LOCATION '/weather/year=2017/month=8/day=1';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-02') LOCATION '/weather/year=2017/month=8/day=2';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-03') LOCATION '/weather/year=2017/month=8/day=3';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-04') LOCATION '/weather/year=2017/month=8/day=4';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-05') LOCATION '/weather/year=2017/month=8/day=5';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-06') LOCATION '/weather/year=2017/month=8/day=6';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-07') LOCATION '/weather/year=2017/month=8/day=7';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-08') LOCATION '/weather/year=2017/month=8/day=8';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-09') LOCATION '/weather/year=2017/month=8/day=9';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-10') LOCATION '/weather/year=2017/month=8/day=10';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-11') LOCATION '/weather/year=2017/month=8/day=11';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-12') LOCATION '/weather/year=2017/month=8/day=12';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-13') LOCATION '/weather/year=2017/month=8/day=13';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-14') LOCATION '/weather/year=2017/month=8/day=14';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-15') LOCATION '/weather/year=2017/month=8/day=15';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-16') LOCATION '/weather/year=2017/month=8/day=16';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-17') LOCATION '/weather/year=2017/month=8/day=17';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-18') LOCATION '/weather/year=2017/month=8/day=18';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-19') LOCATION '/weather/year=2017/month=8/day=19';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-20') LOCATION '/weather/year=2017/month=8/day=20';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-21') LOCATION '/weather/year=2017/month=8/day=21';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-22') LOCATION '/weather/year=2017/month=8/day=22';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-23') LOCATION '/weather/year=2017/month=8/day=23';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-24') LOCATION '/weather/year=2017/month=8/day=24';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-25') LOCATION '/weather/year=2017/month=8/day=25';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-26') LOCATION '/weather/year=2017/month=8/day=26';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-27') LOCATION '/weather/year=2017/month=8/day=27';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-28') LOCATION '/weather/year=2017/month=8/day=28';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-29') LOCATION '/weather/year=2017/month=8/day=29';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-30') LOCATION '/weather/year=2017/month=8/day=30';
ALTER TABLE weather ADD PARTITION (wthr_date='2017-08-31') LOCATION '/weather/year=2017/month=8/day=31';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-01') LOCATION '/weather/year=2016/month=10/day=1';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-02') LOCATION '/weather/year=2016/month=10/day=2';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-03') LOCATION '/weather/year=2016/month=10/day=3';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-04') LOCATION '/weather/year=2016/month=10/day=4';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-05') LOCATION '/weather/year=2016/month=10/day=5';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-06') LOCATION '/weather/year=2016/month=10/day=6';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-07') LOCATION '/weather/year=2016/month=10/day=7';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-08') LOCATION '/weather/year=2016/month=10/day=8';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-09') LOCATION '/weather/year=2016/month=10/day=9';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-10') LOCATION '/weather/year=2016/month=10/day=10';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-11') LOCATION '/weather/year=2016/month=10/day=11';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-12') LOCATION '/weather/year=2016/month=10/day=12';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-13') LOCATION '/weather/year=2016/month=10/day=13';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-14') LOCATION '/weather/year=2016/month=10/day=14';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-15') LOCATION '/weather/year=2016/month=10/day=15';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-16') LOCATION '/weather/year=2016/month=10/day=16';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-17') LOCATION '/weather/year=2016/month=10/day=17';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-18') LOCATION '/weather/year=2016/month=10/day=18';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-19') LOCATION '/weather/year=2016/month=10/day=19';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-20') LOCATION '/weather/year=2016/month=10/day=20';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-21') LOCATION '/weather/year=2016/month=10/day=21';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-22') LOCATION '/weather/year=2016/month=10/day=22';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-23') LOCATION '/weather/year=2016/month=10/day=23';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-24') LOCATION '/weather/year=2016/month=10/day=24';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-25') LOCATION '/weather/year=2016/month=10/day=25';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-26') LOCATION '/weather/year=2016/month=10/day=26';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-27') LOCATION '/weather/year=2016/month=10/day=27';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-28') LOCATION '/weather/year=2016/month=10/day=28';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-29') LOCATION '/weather/year=2016/month=10/day=29';
ALTER TABLE weather ADD PARTITION (wthr_date='2016-10-30') LOCATION '/weather/year=2016/month=10/day=30';

CREATE TABLE expedia row format serde 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
    stored as inputformat
        'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
    outputformat
        'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
    tblproperties ('avro.schema.url'='hdfs:///expedia/expedia.avsc');

LOAD DATA INPATH '/expedia/part-00000-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00001-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00002-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00003-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00004-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00005-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00006-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00007-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00008-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00009-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00010-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00011-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00012-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00013-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00014-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00015-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00016-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00017-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00018-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00019-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00020-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00021-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00022-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00023-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;
LOAD DATA INPATH '/expedia/part-00024-ef2b800c-0702-462d-b37f-5f2fb3a093d0-c000.avro' INTO TABLE expedia;



ADD JAR /Users/andrii/Git/bigdata_samples/Hive/target/scala-2.12/hive-udfs_2.12-1.0.0.jar;
ADD JAR /Users/andrii/Git/bigdata_samples/Hive/target/geohash-1.4.0.jar;
CREATE TEMPORARY FUNCTION hash AS 'ua.bigdata.hive.geo.Hash';

CREATE TABLE hotels_hash AS SELECT h.id, h.name, h.country, h.city, h.address, h.latitude, h.longitude, hash(h.latitude, h.longitude, 4) as hash FROM hotels as h WHERE h.id <> 'Id' AND (h.longitude <> '' OR h.latitude <> '') AND (h.longitude <> 'NA' OR h.latitude <> 'NA');
CREATE TABLE weather_hash AS SELECT w.lng, w.lat, w.avg_tmpr_c, w.wthr_date, hash(w.lat, w.lng, 4) as hash FROM weather as w;
SELECT h.id, h.name, h.country, h.city, h.address, w.avg_tmpr_c, w.wthr_date FROM hotels_hash as h JOIN weather_hash as w ON (h.hash = w.hash) LIMIT 10;

// Kafka export
ADD JAR /Users/andrii/BigData/hive/tmp_lib/hadoop-client-3.3.1.jar;
CREATE EXTERNAL TABLE hotels_weather (id int, name string, country string, city string, address string, avg_tmpr_c double, wthr_date string) STORED BY 'org.apache.hadoop.hive.kafka.KafkaStorageHandler' TBLPROPERTIES ("kafka.topic" = "hotels-hive", "kafka.bootstrap.servers" = "http://localhost:9094", "kafka.serde.class"="org.apache.hadoop.hive.serde2.avro.AvroSerDe");
INSERT INTO TABLE hotels_weather 
  SELECT h.id, h.name, h.country, h.city, h.address, w.avg_tmpr_c, w.wthr_date 
  FROM hotels_hash as h 
  JOIN weather_hash as w ON (h.hash = w.hash);

set hive.mapred.mode = nonstrict;

// Task#1
SELECT w.name, w.year, w.month, max(w.avg_tmpr_c) AS max_tmpr_c
  FROM 
    (
      SELECT h.name, extract(year from w.wthr_date) as year, extract(month from w.wthr_date) as month, w.avg_tmpr_c from hotels_hash as h 
      INNER JOIN weather_hash as w ON (h.hash = w.hash)
    ) w
  GROUP BY w.name, w.year, w.month
  ORDER BY max_tmpr_c DESC
  LIMIT 100;


// Task#2
SELECT e.name, e.year, e.month, count(*) as visitors
  FROM 
    (
      SELECT h.name, e.srch_ci, e.srch_co, extract(year from e.srch_ci) as year, extract(month from e.srch_ci) as month from expedia as e 
      INNER JOIN hotels as h ON (h.id = e.hotel_id) 
      WHERE months_between(e.srch_co, e.srch_ci) >= 0
    ) e
  GROUP BY e.name, e.year, e.month
  ORDER BY visitors DESC
  LIMIT 100;

SELECT e.name, e.year, e.month, count(date_add(e.srch_ci,pe.i)) as visitors
  FROM 
    (
      SELECT h.name, e.srch_ci, e.srch_co, extract(year from e.srch_ci) as year, extract(month from e.srch_ci) as month, ceil(months_between(e.srch_co, e.srch_ci)) as month_diff from expedia as e 
      INNER JOIN hotels as h ON (h.id = e.hotel_id) 
      WHERE months_between(e.srch_co, e.srch_ci) >= 0
    ) e
    LATERAL VIEW posexplode(split(space(datediff(e.srch_co,e.srch_ci)),' ')) pe as i,x
  WHERE dayofmonth(date_add(e.srch_ci,pe.i)) = 1 and date_add(e.srch_ci,pe.i) <> e.srch_ci 
  GROUP BY e.name, e.year, e.month
  ORDER BY visitors DESC
  LIMIT 100;


// Final query for Task#2
SELECT e.name, e.year, e.month, count(date_add(e.srch_ci,pe.i)) as visitors
  FROM 
    (
      SELECT h.name, e.srch_ci, e.srch_co, extract(year from e.srch_ci) as year, extract(month from e.srch_ci) as month, ceil(months_between(e.srch_co, e.srch_ci)) as month_diff from expedia as e 
      INNER JOIN hotels as h ON (h.id = e.hotel_id) 
      WHERE months_between(e.srch_co, e.srch_ci) >= 0
    ) e
    LATERAL VIEW posexplode(split(space(datediff(e.srch_co,e.srch_ci)),' ')) pe as i,x
  WHERE dayofmonth(date_add(e.srch_ci,pe.i)) = 1 or date_add(e.srch_ci,pe.i) = e.srch_ci 
  GROUP BY e.name, e.year, e.month
  ORDER BY visitors DESC
  LIMIT 100;

// Task#3
SELECT e.name, e.user_id, e.srch_ci, e.srch_co, date_add(e.srch_ci,pe.i) as stay_date
  FROM 
    (
      SELECT h.name, e.user_id, e.srch_ci, e.srch_co from expedia as e 
      INNER JOIN hotels as h ON (h.id = e.hotel_id) 
      WHERE datediff(e.srch_co,e.srch_ci) > 7
    ) e
    LATERAL VIEW posexplode(split(space(datediff(e.srch_co,e.srch_ci)),' ')) pe as i,x
  LIMIT 100;

SELECT e.name, e.user_id, e.srch_ci, e.srch_co, e.stay_date, w.wthr_date, w.avg_tmpr_c
  FROM (
    SELECT e.name, e.user_id, e.srch_ci, e.srch_co, e.hash, date_add(e.srch_ci,pe.i) as stay_date
      FROM 
        (
          SELECT h.name, e.user_id, e.srch_ci, e.srch_co, h.hash from expedia as e 
          INNER JOIN hotels_hash as h ON (h.id = e.hotel_id)
          WHERE datediff(e.srch_co,e.srch_ci) > 7
        ) e
        LATERAL VIEW posexplode(split(space(datediff(e.srch_co,e.srch_ci)),' ')) pe as i,x
  ) e
  INNER JOIN weather_hash as w ON (e.hash = w.hash and w.wthr_date = e.stay_date)
  ORDER BY e.name, e.user_id, e.stay_date ASC
  LIMIT 100;

//Final task#3
SELECT e.name, e.user_id, e.srch_ci, e.srch_co, round(avg(w.avg_tmpr_c),1) as avg_tmpr, round(variance(w.avg_tmpr_c),1) as tmpr_diff
  FROM (
    SELECT e.name, e.user_id, e.srch_ci, e.srch_co, e.hash, date_add(e.srch_ci,pe.i) as stay_date
      FROM 
        (
          SELECT h.name, e.user_id, e.srch_ci, e.srch_co, h.hash from expedia as e 
          INNER JOIN hotels_hash as h ON (h.id = e.hotel_id)
          WHERE datediff(e.srch_co,e.srch_ci) > 7
        ) e
        LATERAL VIEW posexplode(split(space(datediff(e.srch_co,e.srch_ci)),' ')) pe as i,x
  ) e
  INNER JOIN weather_hash as w ON (e.hash = w.hash and w.wthr_date = e.stay_date)
  GROUP BY e.name, e.user_id, e.srch_ci, e.srch_co
  ORDER BY e.name, e.user_id, e.srch_ci ASC
  LIMIT 100;


set hive.execution.engine=spark;