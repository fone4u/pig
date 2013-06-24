#!/bin/sh
#author:zhaowu.guo
#date:2013-05-20
if [ $# -eq 1 ]; then
    day=$1
else
    day=$(day)
fi
InputData=/pig/tmp/ttpod_client.$day.gz
dir=/home/hdfs/bin/yyc/mv/pig
Logfile=/var/pig/ttpod_client.$day.log
/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/mv.pig;
exit 0
