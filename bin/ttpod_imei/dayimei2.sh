#!/bin/sh
# athour : chenxin.wen
# date : 2013-5-23

if [ $# == 2 ]; then
	Type=$1
	Date=$2
	Year=$(awk -v f=$Date -F '-' 'BEGIN{print substr(f,0,4)}');
else
	echo "ERROR: you must input two args";
	echo "Example: $0 yyc 2013-05-23";
	exit;
fi

Data_dir=/logs/$Type/dayimei/$Year
Temp_dir=`pwd`/temp/$Type

hadoop fs -test -e $Data_dir
if [ $? != 0 ]; then
	echo  "ERROR: The file or dir("$Data_dir") is not exist!!!"
	exit;
fi

if [ ! -e $Temp_dir ]; then
    mkdir -p $Temp_dir
fi   

hadoop fs -ls $Data_dir | awk '{print $8}'>$Temp_dir/files.tmp

for file in `cat $Temp_dir/files.tmp`
do
	date_0=$(awk  -v f=$file 'BEGIN{print substr(f,index(f,"imei.")+5,10)}');
	hadoop fs -test -e $file/_logs;
	if [ $? == 0 ];then
		hadoop fs -rm -r -skipTrash $file/_logs;
		hadoop fs -rm -r -skipTrash $file/_SUCCESS;
	fi
	/usr/bin/hive -S -e "
	load data inpath '$file' into table default.${Type}_tmp partition(ds='$date_0');	
	";
		
done

	

/usr/bin/hive -S -e "
	set hive.exec.max.dynamic.partitions=100000;
	set hive.exec.max.dynamic.partitions.pernode=100000;
	set hive.exec.compress.output=true;
	set hive.exec.reducers.bytes.per.reducer=500000000;
	set mapred.output.compress=true;
	set mapred.output.compression.codec=org.apache.hadoop.io.compress.GzipCodec;
	set io.compression.codecs=org.apache.hadoop.io.compress.SnappyCodec;
	use db_stat;

	FROM (select * from default.${Type}_tmp where imei!='' and imei is not null and ds='$Date') tmp
	INSERT OVERWRITE TABLE db_stat.ttpod_day_imei PARTITION(type='$Type',time='$Date') 
	select imei,mid,f,v,s,hid,ip,openudid,tuid,SUM(count),active group by imei,mid,f,v,s,hid,ip,openudid,tuid,active;
";
