#!/bin/sh
#author:zhaowu.guo
#date:2013-05-20
if [ $# = 1 ]; then
    day=$1
else
    day=$(day)
fi
InputData=/pig/tmp/ttpod_client.$day.gz
dir=/home/hdfs/bin/song/pig
Logfile=/var/pig/ttpod_client.$Date.log
hadoop fs -test -e $InputData/_SUCCESS
if [ $? != 0 ]; then
        echo  "ERROR: The file or dir("$InputData") is not exist!!!";
else
	/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/song_listen.pig;
fi
exit 0
