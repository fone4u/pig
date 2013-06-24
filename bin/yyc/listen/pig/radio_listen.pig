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
--fu lei pin dao
SONG_online_radio_total = foreach SONG_online_radio{
    index = INDEXOF((chararray)origin,'_',0);
    key = SUBSTRING(origin,0,index);
    key2 = (key=='search-button'?'search':(key=='search-associativeWord'?'search':(key=='search-hotword'?'search':key)));
    generate uid,key2 as key2;
};
SONG_online_radio_total_group = group SONG_online_radio_total by key2;
SONG_online_radio_total_count = foreach SONG_online_radio_total_group{
    uv = distinct SONG_online_radio_total.uid;
    generate flatten(group), COUNT(SONG_online_radio_total) as pv,COUNT(uv) as uv,'$day';
};
STORE SONG_online_radio_total_count INTO 'song_listeninfo' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into song_listeninfo(label,pv,uv,stat_date) values(?,?,?,?)');
