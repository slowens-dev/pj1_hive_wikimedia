##	download the history file for september 2020 
wget https://dumps.wikimedia.org/other/mediawiki_history/2020-10/enwiki/2020-10.enwiki.2020-09.tsv.bz2 -P /mnt/e/data/wiki_history
##	push the data to hdfs
hadoop fs -put /mnt/e/data/wiki_history /user/hive/input
##	run the hql script
#beeline -u jdbc:hive2:// -f q5.hql
