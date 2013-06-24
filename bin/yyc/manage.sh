#!/bin/sh
#author:zhaowu.guo
#date:2013-05-20
if [ $# -eq 1 ]; then
    day=$1
else
    day=$(day)
fi
dir=/home/hdfs/bin/yyc
$dir/mv/mv_stat.sh $day
$dir/listen/listen_stat.sh $day
exit 0
