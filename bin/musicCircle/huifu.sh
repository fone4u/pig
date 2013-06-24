#!/bin/sh
#author:zhaowu.guo
#date:2013-05-18
if [ $# = 1 ]; then
    day=$1
else
    day=$(day)
fi
num=1;
while [ $num -le 19 ]; do
InputData=/pig/tmp/ttpod_client.$day.gz
dir=/home/hdfs/bin/musicCircle/pig
#/usr/bin/pig -p dir=$InputData -p day=$day $dir/music_musicCircle.pig;
/usr/bin/pig -p dir=$InputData -p day=$day $dir/ver.pig;

#/usr/bin/sqoop export  --connect  jdbc:mysql://10.0.2.100:3306/pig --username  user --password stat^2012 --table music_musicCircle_total  --export-dir /var/music_musicCircle/*  --input-fields-terminated-by ',';

num=$((num+1))
day=$(date -d "$day -1day" +%F)
done
exit 0
