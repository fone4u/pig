--ttpod_client json unfasten
--author :chenxin.wen
--date: 2013-05-22

--param: Inputfile
--param: Outputfile

register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
Log = LOAD '$Inputfile' using PigStorage('`') as (ip:chararray,id:int,url:chararray,ma:chararray,kong:chararray,json:chararray);
Log2 = foreach Log generate ip, com.ttpod.stat.exec.JsonToMapExec(json) as jsonMap;
DATA = foreach Log2 generate ip, flatten(jsonMap#'data') as data, flatten(jsonMap#'param') as param;
DATA_F = filter DATA by data is not null;
store DATA into '$Outputfile' using PigStorage('`');
