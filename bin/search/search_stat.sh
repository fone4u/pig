#!/bin/sh
#author:zhaowu.guo
#date:2013-05-20
if [ $# = 1 ]; then
    day=$1
else
    day=$(day)
fi
InputData=/pig/tmp/ttpod_client.$day.gz
dir=/home/hdfs/bin/search/pig
Logfile=/var/pig/ttpod_client.$day.log
dir_tmp=/data/tmp/hdfs/search
#hadoop fs -test -e $InputData/_SUCCESS
#if [ $? != 0 ]; then
#        echo  "ERROR: The file or dir("$InputData") is not exist!!!";
#else
	/usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/search.pig;
        /usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/download.pig;
        /usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/listen.pig;
        /usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/menu.pig;
        /usr/bin/pig -l $Logfile -p dir=$InputData -p day=$day $dir/listen_menu.pig;
#fi
hadoop fs -getmerge /pig/search/success/$day $dir_tmp/success.$day.csv
hadoop fs -getmerge /pig/search/noresult/$day $dir_tmp/noresult.$day.csv
echo "kan fu jian"|mail -s "search_keyword_success_noresult_top500_$day" -a $dir_tmp/success.$day.csv -a $dir_tmp/noresult.$day.csv "zhaowu.guo@ttpod.com moo@ttpod.com"
exit 0
