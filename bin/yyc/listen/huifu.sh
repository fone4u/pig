#!/bin/sh
#author:zhaowu.guo
#date:2013-05-20
if [ $# -eq 1 ]; then
    day=$1
else
    day=$(day)
fi
num=1;
while [ $num -le 4 ]; do
InputData=/pig/tmp/ttpod_client.$day.gz
dir=/home/hdfs/bin/yyc/listen/pig
Logfile=/var/pig/ttpod_client.$day.log
echo 'start`'$(date)>> $dir/time
/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/in_listen.pig
/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/new_listen.pig;
/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/radio_listen.pig;
/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/tj_listen.pig;
/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/tj_son_listen.pig;
/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/radio_son_listen.pig;
/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/kadun_url.pig;
/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/kadun_log.pig;


/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/local_listen.pig
/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/kadun.pig;
echo 'end`'$(date)>> $dir/time

num=$((num+1))
day=$(date -d "$day -1day" +%F)
done
exit 0
