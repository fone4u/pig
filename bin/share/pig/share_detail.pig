register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
LOG = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); --加载数据
LOG1 = filter LOG by data is not null;
GETKEY = foreach LOG1 generate ip,data#'module' as module,data#'type' as type,data#'origin' as origin,param#'uid' as uid,data#'optvalue' as optvalue,data#'value' as value;
SHARE = filter GETKEY by module=='share';
SHARE_group = group SHARE by (type,origin,optvalue);
SHARE_count = foreach SHARE_group {
    uv = distinct SHARE.uid;
    generate flatten(group),SUM(SHARE.value),COUNT(uv),'$day';
};
--dump SHARE_count;
STORE SHARE_count INTO 'share_detail' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into share_detail(type_id,origin,optvalue,pv,uv,stat_date) values(?,?,?,?,?,?)');
