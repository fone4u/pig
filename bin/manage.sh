#!/bin/sh
#filename:manage.sh
#author:zhaowu.guo
#date:2013-05-24
if [ $# -eq 1 ]; then
    day=$1
else
    day=$(day)
fi
dir=/home/hdfs/bin
    $dir/musicCircle/music_musicCircle_total.sh
    $dir/search/search_stat.sh
    $dir/share/share_stat.sh
    $dir/error/error_stat.sh
    $dir/update/update_stat.sh
    $dir/yyc/manage.sh $day
    $dir/recommend/recommend_stat.sh $day
exit 0
