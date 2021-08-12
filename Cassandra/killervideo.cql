DROP KEYSPACE IF EXISTS killr_video;

CREATE KEYSPACE killr_video WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE killr_video;

CREATE TYPE encoding_type (
   encoding TEXT,
   height INT,
   width INT,
   bit_rates SET<TEXT>
);

CREATE TABLE videos (
   video_id TIMEUUID,
   added_date TIMESTAMP,
   description TEXT,
   title TEXT,
   user_id UUID,
   PRIMARY KEY ((video_id))
);

COPY videos FROM '/Users/andrii/BigData/sample_data/labwork/exercise-2/videos.csv' WITH HEADER=true;
SELECT * FROM videos LIMIT 10;
SELECT count(*) FROM videos;
SELECT * FROM videos WHERE video_id = 8a1dee8f-0ef2-11e5-a7f3-8438355b7e3a;
TRUNCATE videos;

CREATE TABLE videos_by_title_year (
   video_id TIMEUUID,
   user_id UUID,
   title TEXT,
   description TEXT,
   added_date TIMESTAMP,
   added_year INT,
   PRIMARY KEY ((title, added_year))
);

COPY videos_by_title_year FROM '/Users/andrii/BigData/sample_data/labwork/exercise-3/videos_by_title_year.csv' WITH HEADER=true;
SELECT * FROM videos_by_title_year WHERE title = 'Datastax - Who We Are' ALLOW FILTERING;
SELECT * FROM videos_by_title_year WHERE title = 'Datastax - Who We Are' AND added_year = 2015;

drop table videos_by_tag_year;
CREATE TABLE videos_by_tag_year (
   tag TEXT,
   added_year INT,
   video_id TIMEUUID,
   added_date TIMESTAMP,
   description TEXT,
   title TEXT,
   user_id UUID,
   PRIMARY KEY (tag, added_year))
WITH CLUSTERING ORDER BY (added_year DESC);

COPY videos_by_tag_year FROM '/Users/andrii/BigData/sample_data/labwork/exercise-4/videos_by_tag_year_1.csv' WITH HEADER=true;


drop table videos_by_tag_year;
CREATE TABLE videos_by_tag_year (
   video_id TIMEUUID,
   added_year INT,
   added_date TIMESTAMP,
   tag TEXT,
   description TEXT,
   title TEXT,
   user_id UUID,
   PRIMARY KEY (video_id, added_year))
WITH CLUSTERING ORDER BY (added_year DESC);

COPY videos_by_tag_year FROM '/Users/andrii/BigData/sample_data/labwork/exercise-4/videos_by_tag_year_2.csv' WITH HEADER=true;

CREATE INDEX ON videos_by_tag_year(description);

SELECT video_id, description, added_year FROM videos_by_tag_year WHERE description = 'database';



ALTER TABLE videos 
ADD tags SET<TEXT>;

COPY videos FROM '/Users/andrii/BigData/sample_data/labwork/exercise-5/videos.csv' WITH HEADER=true;

ALTER TABLE videos 
ADD encoding FROZEN<encoding_type>;

COPY videos (video_id, encoding) FROM '/Users/andrii/BigData/sample_data/labwork/exercise-5/videos_encoding.csv' WITH HEADER=true;

SELECT * FROM videos LIMIT 10;
