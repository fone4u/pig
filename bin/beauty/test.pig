register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
LOG = load '/pig/tmp/ttpod_client.2013-06-18.gz' using PigStorage('`') as (ip:chararray,data:map[],param:map[]);
LOG1 = filter LOG by data is not null;
GETKEY = foreach LOG1 generate data#'module' as module,data#'type' as type,data#'origin' as origin,CONCAT(param#'uid',param#'hid') as uid,data#'optvalue' as optvalue,(int)data#'value' as value;
MUSICC_info = filter GETKEY by module=='musicCircle' and value is not null;
--total
MUSICC_total = foreach MUSICC_info generate uid,value;
MUSICC_total_group = group MUSICC_total all;
MUSICC_total_count = foreach MUSICC_total_group{
uv = distinct MUSICC_total.uid;
generate 'total' as type,SUM(MUSICC_total.value) as pv,COUNT(uv) as uv;
};
--total listen
MUSICC_total_listen_log = filter MUSICC_info by origin matches '.*-playsong';
MUSICC_total_listen = foreach MUSICC_total_listen_log generate uid,value;
MUSICC_total_listen_group = group MUSICC_total_listen all;
MUSICC_total_listen_count = foreach MUSICC_total_listen_group{
uv = distinct MUSICC_total_listen.uid;
generate 'total_listen' as type,SUM(MUSICC_total_listen.value) as pv,COUNT(uv) as uv;
};

store  MUSICC_total_listen_count into '/var/ttt1';
store  MUSICC_total_count into '/var/ttt2';
