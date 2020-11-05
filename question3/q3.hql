-- it became known that the ordering was incorrect in this script
-- the methodology is identical but the order in which the  pages were
-- queried is different here form what produced the data in the presentation

--	all data files have already been loaded. during q2
--	Finding the series of internal links that retains the highest percentage of users
--	series' begin at en.wikipedia.org/wiki/Hotel_California
--	any looping back to a previous position in the series is disregarded
--	when a link would cause 2 series' to converge the one with the higher number is chosen
--	a given link should only appear once across all series'
--	this is because no way of tracking previouse pages of a given user is available
--	if a page sends to a link more than it was sent to by the previous link then the lower value is take
--	this is because a page cannot retain more users than should arrive 


--	start by finding the starting amount of people at Hotel_California
--	TOTAL USERS			13779
select * from clickstream_09_linkout_totals.number;

--	find the 5 most popular links from Hotel_California
--	Hotel_California_(Eagle_album)	2222	16.13%
--	Don_Henley			1537	11.15%
--	Don_Felder			1519	11.02%
--	Eagles_(band)			1335	9.67%
--	Glenn_Frey			1021	7.41%
select * from clickstream_09
 where prev like "Hotel_California"
 and type like "link"
 order by number desc
 limit 5;
--------------------------------------------------------------------------------------------------------

--	get the 3 most popular links for each of the 5
---------------------------------------------------
-------	Hotel_California_(Eagles_album) --- 2222
--	The_Long_Run_(album)		2127	15.44%
--	Hotel_California		2010	disregard-root
--	Their_Greatest_Hits_(1971-1975)	897	6.51%
select * from clickstream_09
 where prev like "Hotel_California_(Eagles_album)"
 and type like "link"
 order by number desc
 limit 3;
----------------------------------------------------
------- Don_Henley --- 1537 
--	Eagles_(band)			3771	disregard-loopback
--	Lois_Chiles			2221	override - 1537
--	Maren_Jensen			2132	override - 1537
select * from clickstream_09
 where prev like "Don_Henley"
 and type like "link"
 order by number desc
 limit 3;

----------------------------------------------------
------- Don_Felder --- 1519
--	Eagles_(band)			1697	disregard-loopback
--	Bernie_Leadon			1059	7.69%
--	Randy_Meisner			705	disregard-Glenn_Frey
select * from clickstream_09
 where prev like "Don_Felder"
 and type like "link"
 order by number desc
 limit 3;

----------------------------------------------------
------- Eagle_(band) --- 1335
--	Glenn_Frey			28354	disregard-loopback
--	Don_Henley			13698	disregard-loopback
--	Joe_Walsh			9630	override - 1335 
select * from clickstream_09
 where prev like "Eagles_(band)"
 and type like "link"
 order by number desc
 limit 3;

----------------------------------------------------
------- Glenn_Frey --- 1021
--	Don_Henley			3198	disregard-loopback
--	Eagles_(band)			2708	disregard-loopback
--	Randy_Meisner			948	6.88%
select * from clickstream_09
 where prev like "Glenn_Frey"
 and type like "link"
 order by number desc
 limit 3;

--------------------------------------------------------------------------------------------------------

--	from this we see that the first most popular page after Hotel_California is Hotel_California_(Eagles_album)
--	the most common link to follow from Hotel_California_(Eagles_album) is The_Long_Run_(album)
--	from here the difference in percentages makes it clear this is the most popular path
--	the next link along the path will be the most popular link from The_Long_Run_(album) that does not violate
--	any of the aforementioned rules of the series

----------------------------------------------------
------- The_Long_Run_(album) --- 2127
--	Eagles_Live			1322	9.59%
--	Hotel_California_(Eagles_album) 654	disregard-loopback
--	I_Can't_Tell_You_Why		470	3.41%
select * from clickstream_09
 where prev like "The_Long_Run_(album)
 and type like "link"
 order by number desc
 limit 3;

--	again it is clear from the difference in percentage that Eagles_Live is the next link
--	Hotel_California -> The_Long_Run_(album) 16.13% -> Eagles_Live 9.59%
----------------------------------------------------
------- Eagles_Live --- 1322
--	Eagles_Greatest_Hits,_Vol._2	1136	8.24%
--	The_Long_Run_(album)		223	disregard-loopback
--	Seven_Bridges_Road		127	0.92%
select * from clickstream_09
 where prev like "Eagles_Live"
 and type like "link"
 order by number desc
 limit 3;

--	again it is clear from the difference in percentage that Eagles_Greatest_Hits,_Vol._2 is the next link
--	Hotel_California -> The_Long_Run_(album) 16.13% -> Eagles_Live 9.59% -> Eagles_Greatest_Hits,_Vol._2 8.24%

----------------------------------------------------
------- Eagles_Greatest_Hits,_Vol._2 --- 1136
--	The_Very_Best_of_the_Eagles	996	7.23%
--	Eagles_Live			186	1.35%
--	Their_Greatest_Hits_(1971-1975)	42	0.30%

select * from clickstream_09
 where prev like "Eagles_Greatest_Hits,_Vol._2"
 and type like "link"
 order by number desc
 limit 3;

--Hotel_California 100% -> The_Long_Run_(album) 16.13% -> Eagles_Live 9.59% -> Eagles_Greatest_Hits,_Vol._2 8.24% -> The_Very_Best_of_the_Eagles 7.23%

