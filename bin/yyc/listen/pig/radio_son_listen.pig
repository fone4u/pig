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
--###dian tai,fen lei,ge shou,sou suo
SONG_online_radio = filter SONG_online_in by (origin matches 'online-.*' or origin matches 'sway_.*' or origin matches 'search-.*' or origin=='favorite_0');
SONG_online_radio_total = foreach SONG_online_radio{
    index = INDEXOF((chararray)origin,'_',0);
    key = SUBSTRING(origin,0,index);
    key2 = (key=='search-button'?'search':(key=='search-associativeWord'?'search':(key=='search-hotword'?'search':key)));
    generate uid,key2 as key2;
};
--zi pin dao
Music_tags = load '/var/database/music_tags' using PigStorage(',') as (id:chararray,pid:chararray,name:chararray);
Music_tags_radio = foreach Music_tags generate CONCAT('online-radio_',id) as id, pid ,name;
Music_tags_style = foreach Music_tags generate CONCAT('online-style_',id) as id, pid ,name;
Channel_Music_uion = union Music_tags_radio,Music_tags_style;
SONG_online_radio_channel_total = filter SONG_online_radio by (origin matches 'online-.*' and not origin matches 'online-singer.*');
SONG_online_radio_channel = join SONG_online_radio_channel_total by origin right outer,Channel_Music_uion by id;
SONG_online_radio_channel_group = group SONG_online_radio_channel by (id,name);
SONG_online_radio_channel_count = foreach SONG_online_radio_channel_group{
    uv = distinct SONG_online_radio_channel.uid;
    generate 'radio',flatten(group),COUNT(SONG_online_radio_channel) as pv,COUNT(uv) as uv,'$day';
};
STORE SONG_online_radio_channel_count INTO 'song_listeninfo_son' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into song_listeninfo_son(pid,sonid,sname,pv,uv,stat_date) values(?,?,?,?,?,?)');
