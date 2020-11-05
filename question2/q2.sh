##	get clickstream data for september 2020 
#wget https://dumps.wikimedia.org/other/clickstream/2020-09/clickstream-enwiki-2020-09.tsv.gz -P /mnt/e/data/clickstream_09
##	get pageviews data for september 2020 
#wget https://dumps.wikimedia.org/other/pageviews/2020/2020-10/pageviews-202009{01..30}-{00..23}0000.gz -P /mnt/e/data/pageviews_09
##	push the data to hdfs
hadoop fs -put /mnt/e/data/pageviews_09/ /user/hive/input/
hadoop fs -put /mnt/e/data/clickstream_09/ /user/hive/input/
##	return to beeline directory ie home and run hql 

#	beeline -u jdbc:hive2:// -f q2.hql
