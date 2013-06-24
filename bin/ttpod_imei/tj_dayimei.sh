#!/bin/sh
#author :chenxin.wen
#time: 2013-5-17
#des: create yyc dayimie (include json nginx)
Type=tj

if [ $# == 1 ];then
   Date=$1;
   YEAR=$(awk  -v f=$Date -F '-' 'BEGIN{print substr(f,0,4)}');
else
   Date=$(date -d "-1 day" +%F);
   YEAR=$(date -d "-1 day" +%Y);
   one_day_ago=$Date;
   two_day_ago=$(date -d "-2 day" +%F);
fi

Datafile1=/pig/tmp/ttpod_client.$Date.gz
Datafile2=/logdata/atjv1/$Date
Datafile3=/logdata/down/$Date
Outputfile=/logs/$Type/dayimei/$YEAR/hdfs.day.imei.$Date.gz
Logfile=/var/log/pig/$Type.$Date.log

hadoop fs -test -e $Datafile1
if [ $? != 0 ];then
	sleep 60m;
fi

/usr/bin/pig -l $Logfile -p dir1=$Datafile1 -p dir2=$Datafile2 -p dir3=$Datafile3 -p output=$Outputfile /home/hdfs/bin/ttpod_imei/pig-scripts/tj.pig;

#dayimei
/home/hdfs/bin/ttpod_imei/dayimei2.sh $Type $Date;

#allimei
/home/hdfs/bin/ttpod_imei/allimei/tj_allimei.sh $one_day_ago $two_day_ago &
