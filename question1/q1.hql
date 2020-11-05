--	wikipedia is the root database
use wikipedia;

--	create table with all hourly pageview records
create table pageviews_20201020
 (domain string, title string, views int, size int)
 row format delimited
 fields terminated by " ";

--	load the data
load data inpath '/user/hive/input/pageviews_20201020' into table pageviews_20201020;

--	create table of hourly pageviews from en.wikipedia.org and en.m.wikipedia.org
create table pageviews_20201020_en as 
 select * from pageviews_20201020 where domain='en' or domain='en.m';

--	create a table where the same title from en and en.m are joined
--	the 24 hourly records are combined into the daily record	
create table pageviews_20201020_en_total as
 select title, sum(views) as views from pageviews_20201020_en
 group by title;

--	get the top 20 visited pages on 2020 10 20 
create table q1_answer as
select title, views from pageviews_20201020_en_total;

select * from q1_answer
 sort by views desc limit 20;
