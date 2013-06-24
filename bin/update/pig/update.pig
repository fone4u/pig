SET default_parallel 8;
register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
A = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); 
AA = filter A by data is not null;
GETKEY = foreach AA generate ip,data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid,data#'optvalue' as optvalue,data#'value' as value;
UPDATE = filter GETKEY by (module=='update' and type=='update' );
UPDATE_group = group UPDATE by origin;
UPDATE_count = foreach UPDATE_group{
     uv = distinct UPDATE.uid;
     generate group,COUNT(UPDATE.value) as pv,COUNT(uv) as uv,'$day';
};
STORE UPDATE_count INTO 'update_total' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into update_total(origin,pv,uv,stat_date) values(?,?,?,?)');
