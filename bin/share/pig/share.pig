register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
LOG = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]);
LOG1 = filter LOG by data is not null;
GETKEY = foreach LOG1 generate data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid,data#'optvalue' as optvalue,data#'value' as value;
SHARE = filter GETKEY by module=='share';
SHARE_total_group = group SHARE all;
SHARE_total_count = foreach SHARE_total_group{
    uv = distinct SHARE.uid;
    generate 'total','null',SUM(SHARE.value) as pv,COUNT(uv),'$day';
};
SHARE_page_group = group SHARE by origin;
SHARE_page_count = foreach SHARE_page_group{
    uv = distinct SHARE.uid;
    generate flatten(group),'null',SUM(SHARE.value) as pv,COUNT(uv),'$day';
};
SHARE_success = filter SHARE by origin!='none';
SHARE_success_group = group SHARE_success by optvalue;
SHARE_success_count = foreach SHARE_success_group{
    uv = distinct SHARE_success.uid;
    generate flatten(group),'null',SUM(SHARE_success.value) as pv,COUNT(uv),'$day';
};
SHARE_type_group = group SHARE by type;
SHARE_type_count = foreach SHARE_type_group{
    uv = distinct SHARE.uid;
    generate flatten(group),'null',SUM(SHARE.value) as pv,COUNT(uv),'$day';
};
--type optvalue
SHARE_type_opt_group = group SHARE by (type,optvalue);
SHARE_type_opt_count = foreach SHARE_type_opt_group{
    uv = distinct SHARE.uid;
    generate flatten(group),SUM(SHARE.value) as pv,COUNT(uv),'$day';
};
result = union SHARE_total_count,SHARE_page_count,SHARE_success_count,SHARE_type_count,SHARE_type_opt_count;
STORE result into 'share_type' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into share_type(type_id,optvalue,pv,uv,stat_date) values(?,?,?,?,?)');

