--param Inputfile
--param Date

register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/hive/lib/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
A = load '/pig/tmp/beauty/beauty_client.2013-05-27.gz' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); --加载数据
AA = filter A by data is not null;
GETKEY = foreach AA generate ip, data#'module' as module,data#'type' as type,data#'origin' as origin;
name = filter GETKEY by origin == 'websocket';
name2 = foreach name generate ip;
store name2 into '/pig/beauty/connect_ip';

