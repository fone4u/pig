register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
LOG = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); 
LOG1 = filter LOG by data is not null;
GETKEY = foreach LOG1 generate data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid,param#'v' as v,(int)data#'value' as value;
MUSICC_info = filter GETKEY by module=='musicCircle';
--total channel
rmf /var/music_musicCircle
MUSICC_total_channel_log = filter MUSICC_info by ((type=='click' and origin=='entry') or (type=='social' and not origin matches 'find-.*' and not origin matches '.*_.*'));
MUSICC_total_channel = foreach MUSICC_total_channel_log{
    index = INDEXOF((chararray)origin,'-',0);
    len = (int)SIZE(origin);
    key = SUBSTRING(origin,0,(index>0?index:len));
    generate key as key,v,uid,value;
};
MUSICC_total_channel_group = group MUSICC_total_channel by (key,v);
MUSICC_total_channel_count = foreach MUSICC_total_channel_group{
    uv = distinct MUSICC_total_channel.uid;
    generate flatten(group),SUM(MUSICC_total_channel.value) as pv,COUNT(uv) as uv,'$day';
};
STORE MUSICC_total_channel_count INTO 'music_musciCircle_ver' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into music_musciCircle_ver(origin,ver,pv,uv,stat_date) values(?,?,?,?,?)');
