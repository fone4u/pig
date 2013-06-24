#!/bin/sh
#author :chenxin.wen
#time: 2013-5-17
#des: create yyc dayimie (include json nginx)

if [ $# == 1 ];then
   Date=$1;
else
   Date=$(date -d "-1 day" +%F);
   one_day_ago=$Date;
   two_day_ago=$(date -d "-2 day" +%F);
fi

#/home/hdfs/bin/ttpod_imei/allimei/macro_allimei.sh $one_day_ago $two_day_ago


/home/hdfs/bin/ttpod_imei/allimei/macro_allimei.sh  2013-06-03 2013-06-02
/home/hdfs/bin/ttpod_imei/allimei/macro_allimei.sh  2013-06-04 2013-06-03
/home/hdfs/bin/ttpod_imei/allimei/macro_allimei.sh  2013-06-05 2013-06-04
/home/hdfs/bin/ttpod_imei/allimei/macro_allimei.sh  2013-06-06 2013-06-05
/home/hdfs/bin/ttpod_imei/allimei/macro_allimei.sh  2013-06-07 2013-06-06
/home/hdfs/bin/ttpod_imei/allimei/macro_allimei.sh  2013-06-08 2013-06-07
/home/hdfs/bin/ttpod_imei/allimei/macro_allimei.sh  2013-06-09 2013-06-08
/home/hdfs/bin/ttpod_imei/allimei/macro_allimei.sh  2013-06-10 2013-06-09
/home/hdfs/bin/ttpod_imei/allimei/macro_allimei.sh  2013-06-11 2013-06-10
