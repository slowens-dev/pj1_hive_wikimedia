--	wikipedia is the root database
use wikipedia;

--	create table for all clickstreams in september
create table clickstream_09
 (prev string, curr string, type string, number int) 
 row format delimited
 fields terminated by '\t';

--	load the clickstream data from wikimedia
load data inpath '/user/hive/input/clickstream_09' into table clickstream_09; 

--	create a table for the total times a reader of an article
--	clicks on an internal link
--	insert sum of all linkouts grouped by title from clickstream
create table clickstream_09_linkout_totals as
 select prev as title, sum(number) as count from clickstream_09
 where type='link' 
 group by prev;

--	create a table for all pageviews from sept 2020
create table pageviews_09
 (domain string, title string, views int, size int)
 row format delimited
 fields terminated by " ";

--	load the sept 2020 pageview data from wikimedia
load data inpath '/user/hive/input/pageviews_09/' into table pageviews_09;

--	create a table for the english pageviews from sept 2020
--	populate it with only the english records from the pageviews_09 table
--	domain like 'en.%' because when I tried using only en and en.m 
--	I would get records that indicate an article has more users
--	clicking an internal link than ever visited the page
--	problem persisted after adding .%
create table pageviews_09_en as
 select * from pageviews_09
 where domain like 'en' or domain like 'en.%';

--	create a table that combines the hourly pageview records into monthly records
create table pageviews_09_en_monthly as 
 select title, sum(views) as views
 from pageviews_09_en
 group by title;

--	join the pageview records and clickstream records for september over the article title
--	the percentage of viewers that followed an internal link to another page will be
--	the number of internal links followed from the page divided by the number of users that visited the page
--	pages with more sends than views persist where there are less than 1M views
--	also one can assume the question is looking for more popular sites so it's fine
create table q2_answer as
select 
 pageviews_09_en_monthly.title as title,
 pageviews_09_en_monthly.views as views,
 clickstream_09_linkout_totals.count as links,
 round(clickstream_09_linkout_totals.count/pageviews_09_en_monthly.views, 2) as link_percent
 from
 pageviews_09_en_monthly inner join clickstream_09_linkout_totals
 on pageviews_09_en_monthly.title=clickstream_09_linkout_totals.title
 where views > 1000000
 order by link_percent desc
 limit 10;      

select * from q2_answer;
