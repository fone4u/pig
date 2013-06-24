SET default_parallel 8;
register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
register /usr/lib/pig/mysql-connector-java-5.1.17.jar;
define getUrlHost com.ttpod.stat.exec.url.GetUrlHost();
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
A = load '$dir' using PigStorage('`') as (ip:chararray,data:map[],param:map[]); 
AA = filter A by data is not null;
GETKEY = foreach AA generate ip,data#'module' as module,data#'type' as type,data#'origin' as origin,(param#'hid' is null?param#'uid':CONCAT(param#'uid',param#'hid')) as uid,data#'optvalue' as optvalue,data#'optvalue2' as optvalue2,data#'value' as value;
MV = filter GETKEY by module=='mv';
--zhanshi
MV_show = filter MV by type=='show';
MV_show_group = group MV_show by (type,origin,optvalue);
MV_show_count = foreach MV_show_group{
     uv = distinct MV_show.uid;
     generate flatten(group),COUNT(MV_show.value) as pv,COUNT(uv) as uv,'$day';
};
--xiazai
MV_down_storm= filter MV by type=='click' and origin=='down-storm-dlg';
MV_down_storm_group = group MV_down_storm by (type,origin,optvalue);
MV_down_storm_count = foreach MV_down_storm_group{
    uv = distinct MV_down_storm.uid;
    generate flatten(group),COUNT(MV_down_storm.value) as pv,COUNT(uv) as uv,'$day';
};
--bofang
MV_click = filter MV by type=='click' and origin!='down-storm-dlg';
MV_click_group = group MV_click by type;
MV_click_count = foreach MV_click_group{
    uv = distinct MV_click.uid;
    generate flatten(group),'total_play','0',COUNT(MV_click.value) as pv,COUNT(uv) as uv,'$day';
};
--mv pin dao bo fang
MV_click_mv = filter MV_click by origin=='online_366';
MV_click_mv_group = group MV_click_mv by type;
MV_click_mv_count = foreach MV_click_mv_group{
    uv = distinct MV_click_mv.uid;
    generate flatten(group),'mv_play','0',COUNT(MV_click_mv.value) as pv,COUNT(uv) as uv,'$day';
};
--no mv pin dao bo fang
MV_click_nomv = filter MV_click by origin!='online_366';
MV_click_nomv_group = group MV_click_nomv by type;
MV_click_nomv_count = foreach MV_click_nomv_group{
    uv = distinct MV_click_nomv.uid;
    generate flatten(group),'nomv_play','0',COUNT(MV_click_nomv.value) as pv,COUNT(uv) as uv,'$day';
};
--bao feng an zhuang
MV_app = filter MV by type=='app';
MV_app_group = group MV_app by (type,origin,optvalue);
MV_app_count = foreach MV_app_group{
    uv = distinct MV_app.uid;
    generate flatten(group),COUNT(MV_app.value) as pv,COUNT(uv) as uv,'$day';
};
--xia zai bao feng
MV_download = filter MV by type=='download';
MV_download_group = group MV_download by (type,origin,optvalue2);
MV_download_count = foreach MV_download_group{
    uv = distinct MV_download.uid;
    generate flatten(group),COUNT(MV_download.value) as pv,COUNT(uv) as uv,'$day';
};
--mv pin dao ye mian dian ji
MV_page = filter GETKEY by module=='page' and type=='online' and origin=='online_366';
MV_page_group = group MV_page by module;
MV_page_count = foreach MV_page_group{
    uv = distinct MV_page.uid;
    generate flatten(group),'click','0',COUNT(MV_page.value) as pv,COUNT(uv) as uv,'$day';
};
result = union MV_show_count,MV_down_storm_count,MV_click_count,MV_click_mv_count,MV_click_nomv_count,MV_app_count,MV_download_count,MV_page_count;
STORE result INTO 'mv_total' USING  org.apache.pig.piggybank.storage.DBStorage('com.mysql.jdbc.Driver','jdbc:mysql://10.0.2.100:3306/pig','user','stat^2012','insert into mv_total(type,origin,optvalue,pv,uv,stat_date) values(?,?,?,?,?,?)');
