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
--####tj rank
SONG_online_tj = filter SONG_online_in by (origin matches 'online_.*' and origin != 'online_278' and origin != 'online_369');
channel = LOAD '/var/database/channel' using PigStorage(',') as(id,pid,name:chararray);
channel_fix = foreach channel generate CONCAT('online_',id) as id, CONCAT('online_',pid) as pid,name;
channel_fil = filter channel_fix by pid!='online_0';
SONG_online_tj_join = join channel_fil by id right outer,SONG_online_tj by origin;
SONG_online_tj_group = group SONG_online_tj_join by pid;
SONG_online_tj_count = foreach SONG_online_tj_group{
    uv = distinct SONG_online_tj_join.uid;
    generate flatten(group),COUNT(SONG_online_tj_join) as pv,COUNT(uv) as uv,'$day';
};
--dump SONG_online_tj_count;
STORE SONG_online_tj_count INTO 'song_listeninfo' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into song_listeninfo(label,pv,uv,stat_date) values(?,?,?,?)');
