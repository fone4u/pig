SET default_parallel 8;
register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
A = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); 
AA = filter A by data is not null;
GETKEY = foreach AA generate ip,data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid,data#'optvalue' as optvalue,data#'value' as value;
SEARCH_menu = filter GETKEY by (module=='song' and type=='show-menu');
SEARCH_menu_group = group SEARCH_menu all;
SEARCH_menu_count = foreach SEARCH_menu_group{
     uv = distinct SEARCH_menu.uid;
     online_pv = distinct SEARCH_menu.origin;
     generate 'search_menu' as key,SUM(SEARCH_menu.value) as pv,COUNT(uv) as uv,COUNT(online_pv) as online_pv,'$day';
};
STORE SEARCH_menu_count INTO 'search_song' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into search_song(origin,pv,uv,online_pv,stat_date) values(?,?,?,?,?)');
