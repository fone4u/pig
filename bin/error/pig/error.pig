register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
LOG = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); --????
LOG1 = filter LOG by data is not null;
GETKEY = foreach LOG1 generate ip,data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid,(int)data#'optvalue' as optvalue,data#'value' as value;
ERROR = filter GETKEY by module=='error';
ERROR_group = group ERROR by type;
ERROR_count = foreach ERROR_group{
    uv = distinct ERROR.uid;
    generate group,SUM(ERROR.value) as pv,COUNT(uv) as uv,'$day';
};
ERROR_origin = filter GETKEY by module=='error' and type!='song';
ERROR_origin_url = foreach ERROR_origin{
    index1 = INDEXOF((chararray)origin,'/',0);
    index2 = INDEXOF((chararray)origin,'/',index1+1);
    index3 = INDEXOF((chararray)origin,'/',index2+1);
    key = SUBSTRING(origin,index2+1,index3);
    generate type,uid,key as key,value;
};
ERROR_origin_url_group = group ERROR_origin_url  by (type,key);
ERROR_origin_url_count = foreach ERROR_origin_url_group{
    uv = distinct ERROR_origin_url.uid;
    generate flatten(group),SUM(ERROR_origin_url.value) as pv,COUNT(uv) as uv,'$day';
};
STORE ERROR_count into 'error_total' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into error_total(type,pv,uv,stat_date) values(?,?,?,?)');
--STORE ERROR_origin_url_count into 'error_url' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into error_url(type,origin,pv,uv,stat_date) values(?,?,?,?,?)');
