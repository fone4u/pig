SET default_parallel 8;
register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
A = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); 
AA = filter A by data is not null;
GETKEY = foreach AA generate ip,data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid,data#'optvalue' as optvalue,data#'value' as value;
SEARCH_total = filter GETKEY by module=='page' and type=='search';
SEARCH_total_group = group SEARCH_total all;
SEARCH_total_count = foreach SEARCH_total_group{
    uv = distinct SEARCH_total.uid;
    generate 'total' as key,SUM(SEARCH_total.value) as pv,COUNT(uv) as uv,'$day';
};
SEARCH_page = foreach SEARCH_total{
    index = INDEXOF((chararray)origin,'_',0);
    len = (int)SIZE(origin);
    key = SUBSTRING(origin,0,(index>0?index:len));
    key2 = (key=='search-button'?'search-button':(key=='search-hotword'?'search-hotword':(key=='search'?'search-changeHotword':(key=='search-associativeWord'?'search-associativeWord':'other'))));    
    generate uid,key2,value,'$day';
};
SEARCH_group = group SEARCH_page by key2;
SEARCH_count = foreach SEARCH_group{
    uv = distinct SEARCH_page.uid;
    generate group as key,SUM(SEARCH_page.value) as pv,COUNT(uv) as uv,'$day';
};
SEARCH_song = filter GETKEY by module=='song' and type=='search';
SEARCH_song_group = group SEARCH_song by optvalue;
SEARCH_song_count = foreach SEARCH_song_group {
    uv = distinct SEARCH_song.uid;
    generate CONCAT('search_result_',group) as key,SUM(SEARCH_song.value) as pv,COUNT(uv) as uv,'$day';
}; 
SEARCH_song_keyword = foreach SEARCH_song{
    index1 = INDEXOF((chararray)origin,'_',0);
    index2 = INDEXOF((chararray)origin,'_',index1+1);
    key = SUBSTRING(origin,index1+1,index2);
    generate uid,key as key,value,optvalue;   
};
SEARCH_song_keyword_group = group SEARCH_song_keyword by (optvalue,key);
SEARCH_song_keyword_count = foreach SEARCH_song_keyword_group{
    uv = distinct SEARCH_song_keyword.uid;
    generate flatten(group),SUM(SEARCH_song_keyword.value) as pv ,COUNT(uv) as uv,'$day';
};
SPLIT  SEARCH_song_keyword_count  into keyword_success IF  optvalue==1, keyword_noresult IF  optvalue==0 ;
keyword_success_order = ORDER  keyword_success by pv DESC;
keyword_noresult_order = ORDER  keyword_noresult  by pv DESC;
NUM_success500 = LIMIT keyword_success_order  500;
NUM_noresult500 = LIMIT keyword_noresult_order  500;
STORE  NUM_success500 into '/pig/search/success/$day';
STORE  NUM_noresult500 into '/pig/search/noresult/$day';
result_click = union SEARCH_total_count,SEARCH_count,SEARCH_song_count;
STORE result_click INTO 'search_total' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into search_total(origin,pv,uv,stat_date) values(?,?,?,?)');

