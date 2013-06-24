rmf /pig/ttpod_client/res
--set default_parallel 8;
register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
--load log
A = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]);
AA = filter A by data is not null;
GETKEY = foreach AA generate ip,data#'module' as module,data#'type' as type,data#'origin' as origin,param#'uid' as uid,data#'is_buffer' as is_buffer , data#'buffer_size' as buffer_size , data#'buffer_count' as buffer_count,data#'url' as url;
SONG_all = filter GETKEY by module=='song' and type=='listen_info';
--online_listen
SONG_online_in = filter SONG_all by origin != 'local';
SONG_online_in_group = group SONG_online_in all;
SONG_online_in_count = foreach SONG_online_in_group{
    uv = distinct SONG_online_in.uid;
    generate 'online_listen',COUNT(SONG_online_in) as pv,COUNT(uv) as uv,'online_listen','$day',0;
};

--online tongji
SONG_Online = filter SONG_all by origin matches 'online_.*';
channel = LOAD '/var/database/channel' using PigStorage(',') as(id,pid,name:chararray) ;
channel_fix = foreach channel generate CONCAT('online_',id) as id, CONCAT('online_',pid) as pid,name;
channel_fil = filter channel_fix by pid!='online_0';

SONG_online_join = join channel_fil by id right outer,SONG_Online by origin;
SONG_online_join_filter = filter SONG_online_join by pid is not null;
SONG_online_group = group SONG_online_join_filter by pid;
SONG_online_result_tmp = foreach SONG_online_group {
	uv = distinct SONG_online_join_filter.uid;
	generate group ,COUNT(SONG_online_join_filter) as pv , COUNT(uv) as uv;
};
--SONG_online_result_tmp_join = join SONG_online_result_tmp by group,channel_fix by id;
--SONG_online_result = foreach SONG_online_result_tmp_join generate group ,pv,uv,name;

--store SONG_online_result into '/pig/ttpod_client/res' using PigStorage(',');

--suo you ping dao
SONG_all_fix = foreach SONG_all{
	index = INDEXOF((chararray)origin,'_',0);
	len = (int)SIZE(origin);
	key = SUBSTRING(origin,0,(index>0?index:len));
	key2 = (key=='sway'?'sway':(key=='search-button'?'search-button':(key=='search-associativeWord'?'search-associativeWord':(key=='online-singer'?'online-singer':(key=='search-hotword'?'search-hotword':origin)))));
	generate uid,key2;
};

SONG_group = group SONG_all_fix by key2 ;
SONG_all_result = foreach SONG_group {
	uv = distinct SONG_all_fix.uid;
	generate group, COUNT(SONG_all_fix) as pv,COUNT(uv) as uv;
};

Music_tags = load '/var/database/music_tags' using PigStorage(',') as (id:chararray,pid:chararray,name:chararray);
Music_tags_radio = foreach Music_tags generate CONCAT('online-radio_',id) as id, pid ,name;
Music_tags_style = foreach Music_tags generate CONCAT('online-style_',id) as id, pid ,name;
Channel_Music_uion = union Music_tags_radio,Music_tags_style,channel_fix;

--he bing jie guo 
result_tmp = union SONG_all_result,SONG_online_result_tmp;
result_tmp_join = join result_tmp by group left outer,Channel_Music_uion by id;
result = foreach result_tmp_join generate group ,pv,uv,name,'$day',0;
--store result into '/pig/ttpod_client/res333' using PigStorage('`');
STORE result INTO 'song_listeninfo' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into song_listeninfo(label,pv,uv,tagName,stat_date,hour) values(?,?,?,?,?,?)');
STORE SONG_online_in_count INTO 'song_listeninfo' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into song_listeninfo(label,pv,uv,tagName,stat_date,hour) values(?,?,?,?,?,?)');
--***ka dun tongji***
SONG_kadun_fil = filter SONG_all by is_buffer==0;
SONG_kadun = foreach SONG_kadun_fil generate getUrlHost(url) as host,is_buffer,((double)buffer_size/1048576.0) as b_size,buffer_count,uid;
SONG_kadun_group = group SONG_kadun by host;
SONG_kadun_res = foreach SONG_kadun_group {
	uv1 = distinct SONG_kadun.uid;
	tmp = filter SONG_kadun by buffer_count>0;
	uv2 = distinct tmp.uid;
	generate group , COUNT(SONG_kadun) as pv1 ,COUNT(tmp) as pv2 , COUNT(uv1) as uv1,COUNT(uv2) as uv2,SUM(SONG_kadun.buffer_count), SUM(SONG_kadun.b_size),'$day',0;
};


STORE SONG_kadun_res into 'song_kadun' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into song_kadun(host,pv_all,pv_ka,uv_all,uv_ka,count_all,buff_size,stat_date,hour) values(?,?,?,?,?,?,?,?,?)');

--illustrate SONG_kadun_res;
--store SONG_kadun_res into '/pig/ttpod_client/kadun333' using PigStorage('`');
