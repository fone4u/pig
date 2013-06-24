register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
LOG = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); 
LOG1 = filter LOG by data is not null;
GETKEY = foreach LOG1 generate data#'module' as module,data#'type' as type,data#'origin' as origin,CONCAT(param#'uid',param#'hid') as uid,data#'optvalue' as optvalue,(int)data#'value' as value;
MUSICC_info = filter GETKEY by module=='musicCircle';
--total
MUSICC_total = foreach MUSICC_info generate uid,value;
MUSICC_total_group = group MUSICC_total all;
MUSICC_total_count = foreach MUSICC_total_group{
    uv = distinct MUSICC_total.uid;
    generate 'total',SUM(MUSICC_total.value) as pv,COUNT(uv) as uv,'$day';
};
rmf /var/music_musicCircle
store MUSICC_total_count into '/var/music_musicCircle/MUSICC_total_count' using PigStorage(',');
--total listen
MUSICC_total_listen_log = filter MUSICC_info by origin matches '.*-playsong';
MUSICC_total_listen = foreach MUSICC_total_listen_log generate uid,value;
MUSICC_total_listen_group = group MUSICC_total_listen all;
MUSICC_total_listen_count = foreach MUSICC_total_listen_group{
    uv = distinct MUSICC_total_listen.uid;
    generate 'total_listen',SUM(MUSICC_total_listen.value) as pv,COUNT(uv) as uv,'$day';
};
store MUSICC_total_listen_count into '/var/music_musicCircle/MUSICC_total_listen_count' using PigStorage(',');
--total favorites
MUSICC_total_create_log = filter MUSICC_info by (origin matches '.*-favorites' and not origin matches '.*-cancel-favorites');
MUSICC_total_create = foreach MUSICC_total_create_log generate uid,value;
MUSICC_total_create_group = group MUSICC_total_create all;
MUSICC_total_create_count = foreach MUSICC_total_create_group{
    uv = distinct MUSICC_total_create.uid;
    generate 'total_create',SUM(MUSICC_total_create.value) as pv,COUNT(uv),'$day';
};
store MUSICC_total_create_count into '/var/music_musicCircle/MUSICC_total_create_count' using PigStorage(',');
MUSICC_total_destroy_log = filter MUSICC_info by (origin matches '.*-favorites' and origin matches '.*-cancel-favorites');
MUSICC_total_detroy = foreach MUSICC_total_destroy_log generate uid,value;
MUSICC_total_detroy_group = group MUSICC_total_detroy all;
MUSICC_total_detroy_count = foreach MUSICC_total_detroy_group{
    uv = distinct MUSICC_total_detroy.uid;
    generate 'total_destroy',SUM(MUSICC_total_detroy.value) as pv,COUNT(uv),'$day';
};
store MUSICC_total_detroy_count into '/var/music_musicCircle/MUSICC_total_detroy_count' using PigStorage(',');
--total followings
MUSICC_total_followings_log = filter MUSICC_info by origin matches '.*-followings';
MUSICC_total_followings = foreach MUSICC_total_followings_log generate optvalue,uid,value;
MUSICC_total_followings_group = group MUSICC_total_followings by optvalue;
MUSICC_total_followings_count = foreach MUSICC_total_followings_group{
    uv = distinct MUSICC_total_followings.uid;
    generate flatten(CONCAT('total_followings_',group)),SUM(MUSICC_total_followings.value) as pv,COUNT(uv) as uv,'$day';
};
store MUSICC_total_followings_count into '/var/music_musicCircle/MUSICC_total_followings_count' using PigStorage(',');
--total following
MUSICC_total_following_log = filter MUSICC_info by origin matches '.*-following';
MUSICC_total_following = foreach MUSICC_total_following_log generate uid,value;
MUSICC_total_following_group = group MUSICC_total_following all;
MUSICC_total_following_count = foreach MUSICC_total_following_group{
    uv = distinct MUSICC_total_following.uid;
    generate 'total_following',SUM(MUSICC_total_following.value) as pv,COUNT(uv) as uv,'$day';
};
store MUSICC_total_following_count into '/var/music_musicCircle/MUSICC_total_following_count' using PigStorage(',');
--total follower
MUSICC_total_follower_log = filter MUSICC_info by origin matches '.*-follower';
MUSICC_total_follower = foreach MUSICC_total_follower_log generate uid,value;
MUSICC_total_follower_group = group MUSICC_total_follower all;
MUSICC_total_follower_count = foreach MUSICC_total_follower_group{
    uv = distinct MUSICC_total_follower.uid;
    generate 'total_follower',SUM(MUSICC_total_follower.value) as pv,COUNT(uv) as uv,'$day';
};
store MUSICC_total_follower_count into '/var/music_musicCircle/MUSICC_total_follower_count' using PigStorage(',');
