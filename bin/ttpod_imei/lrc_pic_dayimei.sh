#!/bin/sh
#author :chenxin.wen
#time: 2013-5-17
#des: create yyc dayimie (include json nginx)


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

lrclog=/data/logs/lrc_pic/lrc.log.imei.$Date.*
piclog=/data/logs/lrc_pic/pic.log.imei.$Date.*

hadoop fs -copyFromLocal $lrclog /logs/lrc/dayimei/$YEAR/
hadoop fs -copyFromLocal $piclog /logs/pic/dayimei/$YEAR/


create_imei()
{
	
	#lrc dayimei
	/home/hdfs/bin/ttpod_imei/dayimei2.sh $1 $2
	#lrc allimei
	/home/hdfs/bin/ttpod_imei/allimei/$1_allimei.sh $3 $4
}
#lrc
create_imei lrc $Date $one_day_ago $two_day_ago & 
#pic
create_imei pic $Date $one_day_ago $two_day_ago & 

#lrc dayimei
#/home/hdfs/bin/ttpod_imei/dayimei2.sh lrc $Date 
#lrc allimei
#/home/hdfs/bin/ttpod_imei/allimei/lrc_allimei.sh $one_day_ago $two_day_ago &

#pic dayimei
#/home/hdfs/bin/ttpod_imei/dayimei2.sh pic $Date 
#pic allimei
#/home/hdfs/bin/ttpod_imei/allimei/pic_allimei.sh $one_day_ago $two_day_ago &
