register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
LOG = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]);
LOG1 = filter LOG by data is not null;
GETKEY = foreach LOG1 generate ip,data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid,data#'optvalue' as optvalue,data#'value' as value;
--dian ji
GAME_click = filter GETKEY by module=='page' and type=='recommend' and not origin matches 'game-tucao';
GAME_click_log = foreach GAME_click{
    origin = (origin=='game-entry'?'game-entry':'game-active');
    generate uid,origin,value;
};
GAME_click_group = group GAME_click_log by origin;
GAME_click_count = foreach GAME_click_group{
    uv = distinct GAME_click_log.uid;
    generate flatten(group),SUM(GAME_click_log.value) as pv,COUNT(uv) as uv,'$day';
};
STORE GAME_click_count into 'recommend_total' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into recommend_total(channel,pv,uv,stat_date) values(?,?,?,?)');
