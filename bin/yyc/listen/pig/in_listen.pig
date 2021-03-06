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
--zai xian zong liang
SONG_online_in = filter SONG_all by origin!='local';
SONG_online_in_group = group SONG_online_in by type;
SONG_online_in_count = foreach SONG_online_in_group{
    uv = distinct SONG_online_in.uid;
    generate 'in_listen' as origin,COUNT(SONG_online_in) as pv,COUNT(uv) as uv,'$day';
};
STORE SONG_online_in_count INTO 'song_listeninfo' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into song_listeninfo(label,pv,uv,stat_date) values(?,?,?,?)');
