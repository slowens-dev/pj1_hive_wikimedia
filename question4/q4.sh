##	https://preview.redd.it/r74r2g8uk7l31.gif?format=mp4&s=81f95438f959ba54a2e06ab618acfe3d9c1e0aca
##	map of relative ipv4 activity observed by ICMP ping requests
##	indicates highests hours of activity by red and lowest by blue
##	yellow sliding windows indicates day time

##	north america is 5 hours behind UTC
##	1300 UTC = 0800	EST (washington)
##	highest activity appears to be midday
##	aligns well with business hours
##	0900 - 1800 local
##	1400 - 2300 utc
hadoop fs -mkdir /user/hive/input/pageviews_usa
hadoop fs -put /mnt/e/data/pageviews_09/pageviews-202009*-{14..23}0000.gz /user/hive/input/pageviews_usa


##	UTC is uk time
##	highest activity begins after lunch
## 	ends with sunset
##	1300 - 1800 
hadoop fs -mkdir /user/hive/input/pageviews_uk
hadoop fs -put /mnt/e/data/pageviews_09/pageviews-202009*-{13..19}0000.gz /user/hive/input/pageviews_uk

##	australia is 11 hours ahead of UTC
##	1200 UTC = 2300 ACT (canberry)
## 	highest activity appears to bracket lunch
##	some activity from 0700 - 10000	=> 1800 - 2100
##	more activity from 1400 - 1800  => 0100 - 0500 
hadoop fs -mkdir /user/hive/input/pageviews_aus
hadoop fs -put /mnt/e/data/pageviews_09/pageviews-202009*-{18..21}0000.gz /user/hive/input/pageviews_aus
hadoop fs -put /mnt/e/data/pageviews_09/pageviews-202009*-{01..05}0000.gz /user/hive/input/pageviews_aus

##	beeline -u jdbc:hive2:// -f q4.hql
