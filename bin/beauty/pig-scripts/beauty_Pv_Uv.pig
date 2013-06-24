--param Inputfile
--param Date

register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/hive/lib/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
A = load '$Inputfile' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); --加载数据
AA = filter A by data is not null;
GETKEY = foreach AA generate  data#'module' as module,data#'type' as type,data#'origin' as origin,param#'v' as v,param#'f' as f, param#'uid' as uid, (int)data#'value' as value;
Beauty_fil = filter GETKEY by module != 'error';
Beauty_group_all = group Beauty_fil by (module,type,origin,v,f);
Beauty_foreach_count = foreach Beauty_group_all {
	uv = distinct Beauty_fil.uid;
	generate flatten(group) , SUM(Beauty_fil.value) as pv , COUNT(uv) as uv ,'$Date','0' ;
};
STORE Beauty_foreach_count into 'beauty_all' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into beauty_all(module,type,origin,v,f,pv,uv,stat_date,hour) values(?,?,?,?,?,?,?,?,?)');

