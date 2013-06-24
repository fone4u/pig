rmf /pig/ttpod_client/res
--set default_parallel 8;
register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
--load log
A = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]);
AA = filter A by data is not null;
GETKEY = foreach AA generate data#'module' as module,data#'type' as type,data#'origin' as origin,data#'is_buffer' as is_buffer,data#'response_time' as response_time,data#'loading_time' as loading_time,data#'buffer_time' as buffer_time,data#'play_time' as play_time,data#'buffer_size' as buffer_size,data#'buffer_count' as buffer_count,data#'url' as url,param#'uid' as uid,param#'hid' as hid,ip,data#'time' as time,param#'net' as net;
SONG_all = filter GETKEY by module=='song' and type=='listen_info' and is_buffer is not null;
SONG_kadun = filter SONG_all by is_buffer==0;
SONG_kadun_log= foreach SONG_kadun generate response_time,loading_time,buffer_time,play_time,buffer_size,buffer_count,getUrlHost(url) as url,uid,hid,ip,time,net;
--lanxun = filter SONG_kadun_log by (url=='bav.kvb.yymommy.com' or url=='hi9.h0b1.musiqueking.com') and buffer_count > 0;
lanxun = filter SONG_kadun_log by buffer_count > 0;
store SONG_kadun_log into '/var/buffer_count/$day' using PigStorage('`');
store lanxun into '/var/lanxun/$day' using PigStorage('`');
