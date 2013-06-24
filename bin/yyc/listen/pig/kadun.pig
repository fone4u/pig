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
GETKEY = foreach AA generate data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid,data#'is_buffer' as is_buffer , data#'buffer_size' as buffer_size , data#'buffer_count' as buffer_count,data#'url' as url;
SONG_all = filter GETKEY by module=='song' and type=='listen_info' and is_buffer is not null;
--***ka dun tongji***
SONG_kadun_fil = filter SONG_all by is_buffer==0;
--kadun
SONG_kadun = foreach SONG_kadun_fil generate buffer_count,uid;
SONG_kadun_group = group SONG_kadun all;
SONG_kadun_count = foreach SONG_kadun_group{
    uv1 = distinct SONG_kadun.uid;
    tmp = filter SONG_kadun by buffer_count>0;
    uv2 = distinct tmp.uid;
    generate COUNT(uv1) as uv1,COUNT(uv2) as uv2,'$day',0;
};
STORE SONG_kadun_count into 'song_kadun' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into song_kadun(uv_all,uv_ka,stat_date,hour) values(?,?,?,?)');
