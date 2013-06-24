#!/bin/sh
#author :chenxin.wen
#time: 2013-5-22
#des: create yyc dayimie (include json nginx)

Date=$1

if [ $# == 1 ];then
   Date=$1;
else
   Date=$(date -d "-1 day" +%F);
fi
#echo $(date -d "-1 day" +%F)


JsonData=/logdata/beauty_client/$Date
OutputData=/pig/tmp/beauty/beauty_client.$Date.gz

Logfile=/var/pig/beauty_client.$Date.log

hadoop fs -test -e $JsonData
if [ $? != 0 ]; then
        echo  "ERROR: The file or dir("$JsonData") is not exist!!!";
else
	/usr/bin/pig -l $Logfile -p Inputfile=$JsonData -p Outputfile=$OutputData /home/hdfs/bin/beauty/pig-scripts/unfastenJson.pig;
fi
