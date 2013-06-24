#!/bin/sh
#author:zhaowu.guo
#date:2013-05-20
if [ $# = 1 ]; then
    day=$1
else
    day=$(day)
fi
InputData=/pig/tmp/ttpod_client.$day.gz
dir=/home/hdfs/bin/recommend/pig
#Logfile=/var/pig/ttpod_client.$day.log
#hadoop fs -test -e $InputData/_SUCCESS
#if [ $? != 0 ]; then
#    echo  "ERROR: The file or dir("$InputData") is not exist!!!";
#else
    /usr/bin/pig -p dir=$InputData -p day=$day $dir/recommend_total.pig;
    /usr/bin/pig -p dir=$InputData -p day=$day $dir/recommend_button.pig;
    /usr/bin/pig -p dir=$InputData -p day=$day $dir/recommend_end.pig;
#fi
exit 0
