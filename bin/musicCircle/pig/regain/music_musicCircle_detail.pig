register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
LOG = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); 
LOG1 = filter LOG by data is not null;
GETKEY = foreach LOG1 generate data#'module' as module,data#'type' as type,data#'origin' as origin,CONCAT(param#'uid',param#'hid') as uid,data#'optvalue' as optvalue,(int)data#'value' as value;
MUSICC_info = filter GETKEY by module=='musicCircle';
--detail
MUSICC_detail_group = group MUSICC_info by (type,origin,optvalue);
MUSICC_detail_count = foreach MUSICC_detail_group{
    uv = distinct MUSICC_info.uid;
    generate flatten(group),SUM(MUSICC_info.value),COUNT(uv),'$day',0;
};
STORE MUSICC_detail_count INTO 'music_musciCircle_detail' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into music_musciCircle_detail(type,origin,optvalue,pv,uv,stat_date,hour) values(?,?,?,?,?,?,?)');
