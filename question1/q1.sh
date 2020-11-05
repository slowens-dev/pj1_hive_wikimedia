##	get gzipped tsv files for every hour of 10/20/2020

wget https://dumps.wikimedia.org/other/pageviews/2020/2020-10/pageviews-20201020-{00..23}0000.gz -P /mnt/e/data/pageviews_20201020/

##	put it in the hdfs
hadoop fs -put /mnt/e/data/pageviews_20201020/ /user/hive/input/

##	run the hive script with beeline alias
behive q1.hql;
