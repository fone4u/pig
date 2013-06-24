#!/bin/sh
#author:zhaowu.guo
#date:2013-05-20
if [ $# -eq 1 ]; then
    day=$1
else
    day=$(day)
fi
dir=/home/hdfs/bin/yyc
num=1;
while [ $num -le 18 ]; do
    $dir/mv/mv_stat.sh $day
    $dir/listen/listen_stat.sh $day

num=$((num+1))
day=$(date -d "$day -1day" +%F)
done
exit 0
