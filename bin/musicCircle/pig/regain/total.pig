register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
LOG = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); 
LOG1 = filter LOG by data is not null;
GETKEY = foreach LOG1 generate data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid,data#'optvalue' as optvalue,(int)data#'value' as value;
MUSICC_info = filter GETKEY by module=='musicCircle';
--total channel
rmf /var/music_musicCircle
MUSICC_total_channel_log = filter MUSICC_info by (type=='social' and not origin matches 'find-.*' and not origin matches '.*_.*');
MUSICC_total_channel = foreach MUSICC_total_channel_log{
    index = INDEXOF((chararray)origin,'-',0);
    len = (int)SIZE(origin);
    key = SUBSTRING(origin,0,(index>0?index:len));
    generate key as key,uid,value;
};
MUSICC_total_channel_group = group MUSICC_total_channel by key;
MUSICC_total_channel_count = foreach MUSICC_total_channel_group{
    uv = distinct MUSICC_total_channel.uid;
    generate flatten(CONCAT('total_',group)),SUM(MUSICC_total_channel.value) as pv,COUNT(uv) as uv,'$day';
};
store MUSICC_total_channel_count into '/var/music_musicCircle/MUSICC_total_channel_count' using PigStorage(',');
