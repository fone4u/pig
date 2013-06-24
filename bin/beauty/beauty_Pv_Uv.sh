#!/bin/sh
#author :chenxin.wen
#time: 2013-5-22
#des: create yyc dayimie (include json nginx)


if [ $# == 1 ];then
   Date=$1;
else
   Date=$(date -d "-1 day" +%F);
fi
Datafile=/logdata/beauty_client/$Date

Logfile=/var/log/pig/beauty_client.$Date.log

MiddJsonData=/pig/tmp/beauty/beauty_client.$Date.gz
hadoop fs -test -e $MiddJsonData
if [ $? != 0 ];then
	/home/hdfs/bin/beauty/unfastenJson.sh
fi
#/usr/bin/pig -l $Type.$1.log -p JsonData=/pig/tmp.gz -p NginxData=/logdata/yycv1/2013-05-12 -p output=$Outputfile -p DATE=$1 yyc.pig;
/usr/bin/pig -l $Logfile -p Inputfile=$MiddJsonData -p Date=$Date /home/hdfs/bin/beauty/pig-scripts/beauty_Pv_Uv.pig
