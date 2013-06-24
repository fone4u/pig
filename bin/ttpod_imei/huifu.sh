#!/bin/sh
# author :chenxin.wen
#!/bin/sh
# author :chenxin.wen
# date : 2013-5-13

#HADOOP_HOME=/usr/lib/hadoop-2.0.2-alpha 

dd=("2013-06-06" "2013-06-07" "2013-06-08" "2013-06-09" "2013-06-10" "2013-06-11" "2013-06-12" "2013-06-13" "2013-06-14")
#dd=("2013-06-06" "2013-06-16")

#yewu=("lrc" "pic" "yyc" "tj" "update")
yewu=("yyc")


for y in ${yewu[*]}
do
        for d in ${dd[*]} 
	do 
		/home/hdfs/bin/ttpod_imei/dayimei2.sh $y $d 	
	done

done
