#!/bin/sh
#author :chenxin.wen
#time: 2013-5-17
#des: create yyc dayimie (include json nginx)

Date=$1

if [ $# == 1 ];then
   Date=$1;
else
   Date=$(date -d "-1 day" +%F);
fi
#echo $(date -d "-1 day" +%F)


JsonData=/logdata/ttpod_client/$Date
OutputData=/pig/tmp/ttpod_client.$Date.gz

Logfile=/var/log/pig/ttpod_client.$Date.log

hadoop fs -test -e $JsonData
if [ $? != 0 ]; then
        echo  "ERROR: The file or dir("$JsonData") is not exist!!!";
else
	/usr/bin/pig  -l $Logfile -p JsonData=$JsonData -p Date=$Date /home/hdfs/bin/ttpod_imei/pig-scripts/unfastenJson.pig;
fi

