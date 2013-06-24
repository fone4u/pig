register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
A = load '/pig/tmp/ttpod_client.$date.gz' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); --加载数据
AA = filter A by data is not null;
GETKEY = foreach AA  generate data#'module' as module,data#'type' as type,param#'uid' as uid,data#'song_id' as songId;
SONG_listen = filter GETKEY by module=='song' and  type=='listen_info' and uid is not null;
SONG_listen_fil = foreach SONG_listen generate uid,songId;
SONG_listen_group = group SONG_listen_fil  by (uid,songId) parallel 12;
SONG_listen_count = foreach SONG_listen_group {
	generate flatten(group) , COUNT(SONG_listen_fil);
};
STORE SONG_listen_count into '/pig/songlisten/$date' Using PigStorage('`');
