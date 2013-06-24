#!/bin/sh
# athour : chenxin.wen
# date : 2013-5-23

if [ $# == 2 ]; then
	one_day_ago=$1;
	two_day_ago=$2;
else
	echo "ERROR: you must put two args"
	echo "Example: $0 Dayimei_time Allimei_time";
	exit;
fi

#type pt time s(like)
/usr/bin/hive -S -e "
	set hive.exec.max.dynamic.partitions=100000;
        set hive.exec.max.dynamic.partitions.pernode=100000;
	set hive.exec.reducers.bytes.per.reducer=300000000;
	set hive.exec.compress.output=true;
	set mapred.output.compress=true;
	set mapred.output.compression.codec=org.apache.hadoop.io.compress.GzipCodec;
	set io.compression.codecs=org.apache.hadoop.io.compress.SnappyCodec;
	
	
	--macro android
	INSERT OVERWRITE TABLE  db_stat.ttpod_all_imei  PARTITION(type='macro', pt='android', time='$one_day_ago')
	SELECT if(d.imei IS NULL,a.imei,d.imei),
	COALESCE(d.clicks+a.clicks,d.clicks,a.clicks),COALESCE(d.regisday+a.regisday,d.regisday,a.regisday+1),
	COALESCE(d.modday,a.modday+1),COALESCE(d.userday+a.userday,d.userday,a.userday) 
	FROM (SELECT imei,sum(count) as clicks,1 as regisday,1 as modday,1 as userday FROM db_stat.ttpod_day_imei where s like '%200' and time='$one_day_ago' group by imei) d 
	FULL OUTER JOIN 
	(SELECT * FROM db_stat.ttpod_all_imei where type='macro' and pt='android' and time='$two_day_ago') a ON (d.imei=a.imei);

	--macro ios
	INSERT OVERWRITE TABLE  db_stat.ttpod_all_imei  PARTITION(type='macro', pt='ios', time='$one_day_ago')
	SELECT if(d.imei IS NULL,a.imei,d.imei),
	COALESCE(d.clicks+a.clicks,d.clicks,a.clicks),COALESCE(d.regisday+a.regisday,d.regisday,a.regisday+1),
	COALESCE(d.modday,a.modday+1),COALESCE(d.userday+a.userday,d.userday,a.userday) 
	FROM (SELECT imei,sum(count) as clicks,1 as regisday,1 as modday,1 as userday FROM db_stat.ttpod_day_imei where s like 's3_0' and time='$one_day_ago' group by imei) d 
	FULL OUTER JOIN 
	(SELECT * FROM db_stat.ttpod_all_imei where type='macro' and pt='ios' and time='$two_day_ago') a ON (d.imei=a.imei);

	--macro java
	INSERT OVERWRITE TABLE  db_stat.ttpod_all_imei  PARTITION(type='macro', pt='java', time='$one_day_ago')
	SELECT if(d.imei IS NULL,a.imei,d.imei),
	COALESCE(d.clicks+a.clicks,d.clicks,a.clicks),COALESCE(d.regisday+a.regisday,d.regisday,a.regisday+1),
	COALESCE(d.modday,a.modday+1),COALESCE(d.userday+a.userday,d.userday,a.userday) 
	FROM (SELECT imei,sum(count) as clicks,1 as regisday,1 as modday,1 as userday FROM db_stat.ttpod_day_imei where s like 's12_' and time='$one_day_ago' group by imei) d 
	FULL OUTER JOIN 
	(SELECT * FROM db_stat.ttpod_all_imei where type='macro' and pt='java' and time='$two_day_ago') a ON (d.imei=a.imei);

	--macro symbian
	INSERT OVERWRITE TABLE  db_stat.ttpod_all_imei  PARTITION(type='macro', pt='symbian', time='$one_day_ago')
	SELECT if(d.imei IS NULL,a.imei,d.imei),
	COALESCE(d.clicks+a.clicks,d.clicks,a.clicks),COALESCE(d.regisday+a.regisday,d.regisday,a.regisday+1),
	COALESCE(d.modday,a.modday+1),COALESCE(d.userday+a.userday,d.userday,a.userday) 
	FROM (SELECT imei,sum(count) as clicks,1 as regisday,1 as modday,1 as userday FROM db_stat.ttpod_day_imei where  s like 's0__' and time='$one_day_ago' group by imei) d 
	FULL OUTER JOIN 
	(SELECT * FROM db_stat.ttpod_all_imei where type='macro' and pt='symbian' and time='$two_day_ago') a ON (d.imei=a.imei);

	--macro other
	INSERT OVERWRITE TABLE  db_stat.ttpod_all_imei  PARTITION(type='macro', pt='other', time='$one_day_ago')
	SELECT if(d.imei IS NULL,a.imei,d.imei),
	COALESCE(d.clicks+a.clicks,d.clicks,a.clicks),COALESCE(d.regisday+a.regisday,d.regisday,a.regisday+1),
	COALESCE(d.modday,a.modday+1),COALESCE(d.userday+a.userday,d.userday,a.userday) 
	FROM (SELECT imei,sum(count) as clicks,1 as regisday,1 as modday,1 as userday FROM db_stat.ttpod_day_imei where  s  not like '%200' and s  not like 's3_0' and s  not like 's12_' and s  not like 's0__' and time='$one_day_ago' group by imei) d 
	FULL OUTER JOIN 
	(SELECT * FROM db_stat.ttpod_all_imei where type='macro' and pt='other' and time='$two_day_ago') a ON (d.imei=a.imei);
";
