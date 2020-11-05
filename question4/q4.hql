use wikipedia;

----------- USA ------------------
-------create table for all pageviews
create table pageviews_usa
 (domain string, title string, views int, size int)
 row format delimited
 fields terminated by " ";
-------load data from hdfs
load data inpath "/user/hive/input/pageviews_usa/" into table pageviews_usa;
-------create table for only english pageviews
create table pageviews_usa_en as
 select title, views from pageviews_usa
 where domain like "en" or domain like "en.m";
-------drop the non english table to save space
drop table pageviews_usa;
-------create table for the totals views per page
create table pageviews_usa_en_totals as
 select title, sum(views) from pageviews_usa_en as views
 group by title;
-------drop the non totals table to save space;
drop table pageviews_usa_en;
-------create the solution table by getting the top 20 pages
create table q4_usa_answer as
 select title, views from pageviews_usa_en_totals
 order by views desc limit 20; 
-------show the results
select * from q4_usa_answer;

----------- UK ------------------
-------create table for all pageviews
create table pageviews_uk
 (domain string, title string, views int, size int)
 row format delimited
 fields terminated by " ";
-------load data from hdfs
load data inpath "/user/hive/input/pageviews_uk/" into table pageviews_uk;
-------create table for only english pageviews
create table pageviews_uk_en as
 select title, views from pageviews_uk
 where domain like "en" or domain like "en.m";
-------drop the non english table to save space
drop table pageviews_uk;
-------create table for the totals views per page
create table pageviews_uk_en_totals as
 select title, sum(views) from pageviews_uk_en as views
 group by title;  
-------drop the non totals table to save space;
drop table pageviews_usa_en;
-------create the solution table by getting the top 20 pages
create table q4_uk_answer as
 select title, views from pageviews_uk_en_totals
 order by views desc limit 20; 
-------show the results
select * from q4_uk_answer;

----------- AUS ------------------
-------create table for all pageviews
create table pageviews_aus
 (domain string, title string, views int, size int)
 row format delimited
 fields terminated by " ";
-------load data from hdfs
load data inpath "/user/hive/input/pageviews_aus/" into table pageviews_aus;
-------create table for only english pageviews
create table pageviews_aus_en as
 select title, views from pageviews_aus
 where domain like "en" or domain like "en.m";
-------drop the non english table to save space
drop table pageviews_aus;
-------create table for the totals views per page
create table pageviews_aus_en_totals as
 select title, sum(views) from pageviews_aus_en as views
 group by title;  
-------drop the non totals table to save space;
drop table pageviews_usa_en;
-------create the solution table by getting the top 20 pages
create table q4_aus_answer as
 select title, views from pageviews_aus_en_totals
 order by views desc limit 20; 
-------show the results
select * from q4_aus_answer;
