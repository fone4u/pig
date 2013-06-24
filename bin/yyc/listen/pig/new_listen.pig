register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
--load log
A = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]);
AA = filter A by data is not null;
GETKEY = foreach AA generate data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid;
SONG_all = filter GETKEY by module=='song' and type=='listen_info';
SONG_online_in = filter SONG_all by origin!='local';
SONG_online_new = filter SONG_online_in by (origin == 'online_278' or origin == 'online_369');
SONG_online_new_group = group SONG_online_new by origin;
SONG_online_new_count = foreach SONG_online_new_group{
    uv = distinct SONG_online_new.uid;
    generate flatten(group),COUNT(SONG_online_new) as pv,COUNT(uv) as uv,'$day';
}; 
STORE SONG_online_new_count INTO 'song_listeninfo' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into song_listeninfo(label,pv,uv,stat_date) values(?,?,?,?)');
