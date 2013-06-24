#!/bin/sh
#author :chenxin.wen
#time: 2013-5-17
#des: create yyc dayimie (include json nginx)
Type=yyc

if [ $# == 2 ];then
   Date=$1;
   YEAR=$(awk  -v f=$Date -F '-' 'BEGIN{print substr(f,0,4)}');
   one_day_ago=$1;
   two_day_ago=$2;
else
   Date=$(date -d "-1 day" +%F);
   YEAR=$(date -d "-1 day" +%Y);
   one_day_ago=$Date;
   two_day_ago=$(date -d "-2 day" +%F);
fi
Outputfile=/logs/yyc/dayimei/$YEAR/hdfs.day.imei.$Date.gz
Logfile=/var/log/pig/$Type.$Date.log

heartlog=/data/logs/lrc_pic/plaza.heart.imei.$Date.*
yyclog=/data/logs/lrc_pic/yyc.log.imei.$Date.a[a-z].*

hadoop fs -copyFromLocal $heartlog /logs/yyc/dayimei/$YEAR/
hadoop fs -copyFromLocal $yyclog /logs/yyc/dayimei/$YEAR/

/usr/bin/pig -l $Logfile -p date=$Date -p output=$Outputfile /home/hdfs/bin/ttpod_imei/pig-scripts/yyc.pig
#dayimei
/home/hdfs/bin/ttpod_imei/dayimei2.sh $Type $Date;
# allimei
/home/hdfs/bin/ttpod_imei/allimei/yyc_allimei.sh $one_day_ago $two_day_ago &

