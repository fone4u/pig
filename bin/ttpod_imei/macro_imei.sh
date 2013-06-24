#!/bin/sh
#author :chenxin.wen
#time: 2013-5-17
#des: create yyc dayimie (include json nginx)

if [ $# == 2 ];then
   Date=$1;
   one_day_ago=$1;
   two_day_ago=$2;
else
   Date=$(date -d "-1 day" +%F);
   one_day_ago=$Date;
   two_day_ago=$(date -d "-2 day" +%F);
fi

/home/hdfs/bin/ttpod_imei/allimei/macro_allimei.sh $one_day_ago $two_day_ago


