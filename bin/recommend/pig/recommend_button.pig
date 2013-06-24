register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
LOG = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]);
LOG1 = filter LOG by data is not null;
GETKEY = foreach LOG1 generate ip,data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid,data#'optvalue' as optvalue,data#'value' as value;
--xia zai an niu
DOWNLOAD_recommend_adid = filter GETKEY by module=='download' and type=='recommend' and origin matches 'game.*' and not origin matches 'game-tucao.*';
DOWNLOAD_recommend_adid_adname1 = foreach DOWNLOAD_recommend_adid{
    index1 = INDEXOF((chararray)origin,'_',0);
    index2 = INDEXOF((chararray)origin,'_',index1+1);
    index3 = INDEXOF((chararray)origin,'_',index2+1);
    index4 = INDEXOF((chararray)origin,'_',index3+1);
    len = (int)SIZE(origin);
    key1 = SUBSTRING(origin,0,(index1>0?index1:len));
    key2 = SUBSTRING(origin,index1+1,(index2>0?index2:0));
    key3 = SUBSTRING(origin,index2+1,(index3>0?index3:0));
    key4 = SUBSTRING(origin,index3+1,(index4>0?index4:0));
    key5 = SUBSTRING(origin,index4+1,(index4+2>0?index4+2:0));
    generate uid,key1 as key1,key2 as key2,key3 as key3,key4 as key4,key5 as key5;
};
DOWNLOAD_recommend_adid_adname = filter DOWNLOAD_recommend_adid_adname1 by key1 is not null;
DOWNLOAD_recommend_adid_adname_group = group DOWNLOAD_recommend_adid_adname by  (key1,key2,key3,key4,key5);
DWONLOAD_recommend_adid_adname_count = foreach DOWNLOAD_recommend_adid_adname_group{
    uv = distinct DOWNLOAD_recommend_adid_adname.uid;
    generate flatten(group),COUNT(DOWNLOAD_recommend_adid_adname),COUNT(uv),'$day';
};
STORE DWONLOAD_recommend_adid_adname_count into 'recommend_download_button' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into recommend_download_button(channel,adid,order_num,adname,ds,pv,uv,stat_date) values(?,?,?,?,?,?,?,?)');

