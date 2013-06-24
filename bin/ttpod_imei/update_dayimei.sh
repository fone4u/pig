#!/bin/sh
#author :chenxin.wen
#time: 2013-5-17
#des: create yyc dayimie (include json nginx)
Type=update

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

#dayImei
/home/hdfs/bin/ttpod_imei/dayimei2.sh $Type $Date;

#allimei
/home/hdfs/bin/ttpod_imei/allimei/update_allimei.sh $one_day_ago $two_day_ago &
