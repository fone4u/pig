#!/bin/sh
#author:chenxin.wen
#date:2013-05-21
if [ $# = 1 ]; then
    date=$1
else
    date=$(day)
fi
Macro_data=/user/hive/warehouse/db_stat.db/ttpod_all_imei/type=macro/pt=android/time=$date
hadoop fs -test -e $Macro_data
if [ $? != 0 ]; then
	sleep 100m;
	#exit 0;
fi

/usr/bin/pig  -l pig.$date.log -p date=$date /home/hdfs/bin/songlisten/songlisten_uid_songid.pig;
OutPutfile=/pig/songlisten/$date
hadoop fs -test -e $OutPutfile/_SUCCESS
if [ $? != 0 ]; then
	exit 0;
else
	hadoop fs -rm -r  -skipTrash $OutPutfile/_logs;
	hadoop fs -rm -r  -skipTrash $OutPutfile/_SUCCESS;
	# load into db_stat.song_listen
	/usr/bin/hive -S -e "USE db_stat;
	load data inpath '$OutPutfile' overwrite into table db_stat.song_listen  partition(ds='$date');
	";

	/usr/bin/hive -S -e "

	insert overwrite directory '/pig/songlisten/result/$date'
	select  b.f ,count(a.imei ) , sum(case when  c.count is null  then 0L else  c.count  end),
	sum(case when  c.count =1  then 1 else  0  end),
	sum(case when  c.count =2  then 1 else  0  end),
	sum(case when  c.count =3  then 1 else  0  end),
	sum(case when  c.count =4  then 1 else  0  end),
	sum(case when  c.count =5  then 1 else  0  end),
	sum(case when  c.count =6  then 1 else  0  end),
	sum(case when  c.count =7  then 1 else  0  end),
	sum(case when  c.count =8  then 1 else  0  end),
	sum(case when  c.count =9  then 1 else  0  end),
	sum(case when  c.count =10  then 1 else  0  end),
	sum(case when  c.count =11  then 1 else  0  end),
	sum(case when  c.count =12  then 1 else  0  end),
	sum(case when  c.count =13  then 1 else  0  end),
	sum(case when  c.count =14  then 1 else  0  end),
	sum(case when  c.count =15  then 1 else  0  end),
	sum(case when  c.count >15 and c.count<20  then 1 else  0  end),
	sum(case when  c.count >19 and c.count<30  then 1 else  0  end),
	sum(case when  c.count >29 and c.count<40  then 1 else  0  end),
	sum(case when  c.count >39  then 1 else  0  end),'$date'
	 from  (select imei from db_stat.ttpod_all_imei where type='macro' and regisday=1 and time='$date') a 
	LEFT  OUTER JOIN (select  distinct imei ,f  from db_stat.ttpod_day_imei  where imei !=''  and imei  is not null  and time='$date' ) b ON (a.imei=b.imei) 
	LEFT  OUTER JOIN (select imei ,SUM(count)  as count from db_stat.song_listen  where  ds='$date' group by imei) c ON (a.imei=c.imei) group by b.f;

	";

	/usr/bin/sqoop export  --connect  jdbc:mysql://10.0.2.100:3306/pig --username  user --password stat^2012 --table ttpod_song_f  --export-dir /pig/songlisten/result/$date  --input-fields-terminated-by '\001';

#	sqoop-export  --connect  jdbc:mysql://10.0.2.100:3306/pig --username  user --password stat^2012 --table  ttpod_song_f  --export-dir  /pig/songlisten/result/$date
fi
exit 0
