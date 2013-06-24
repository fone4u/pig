--ttpod_client json unfasten
--author :chenxin.wen
--date: 2013-05-17

--param: JsonData (the ttpod_client log)
--param: Date (the log's date)

register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
Log = LOAD '$JsonData' using PigStorage('`') as (ip:chararray,id:int,url:chararray,ma:chararray,kong:chararray,json:chararray);
Log2 = foreach Log generate ip, com.ttpod.stat.exec.JsonToMapExec(json) as jsonMap;
DATA = foreach Log2 generate ip, flatten(jsonMap#'data') as data, flatten(jsonMap#'param') as param;
DATA_F = filter DATA by data is not null;
store DATA into '/pig/tmp/ttpod_client.$Date.gz' using PigStorage('`');
--store Log2 into '/pig/tmp/ttpod_client.$Date.2.gz' using PigStorage('`');
--dump Log2;
