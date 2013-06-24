--结合JSon解析后的数据和nginx形式的数据产生tj的dayimei
--param  dir1=jsondate
--param  dir2=atjv1
--param  dir3=down
--param  output=logsimei
SET default_parallel 2;
register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
A = load '$dir1'  using PigStorage('`') as (ip:chararray,data:map[],param:map[]);
GETKEY = foreach A generate data#'module' as module,data#'type' as type,data#'origin' as origin,param#'uid' as uid,param#'mid' as mid,param#'f' as f,param#'v' as v,param#'s' as s,ip ,param#'hid' as hid,param#'openudid' as openudid,param#'tid' as tuid,param#'active' as active;
TJ_all = filter GETKEY by (module=='page' and type=='recommend') or (module=='setting') or (module=='page' and type=='click' and origin=='recommend') or (module=='download' and type=='recommend');
TJ_fil= foreach TJ_all generate (chararray)uid,(chararray)mid,(chararray)f,(chararray)v,(chararray)s,(chararray)ip,(chararray)hid,(chararray)openudid,(chararray)tuid,(chararray)active;

--atjv1的日志
B = load '$dir2' using PigStorage('`');
BB = foreach B generate getQueryItem((chararray)$7,'uid') as uid,getQueryItem((chararray)$7,'mid') as mid,getQueryItem((chararray)$7,'f') as f ,getQueryItem((chararray)$7,'v') as v,getQueryItem((chararray)$7,'s') as s,$0 as ip,getQueryItem((chararray)$7,'hid') as hid,getQueryItem((chararray)$7,'openudid') as openudid,getQueryItem((chararray)$7,'tid') as tuid, getQueryItem((chararray)$7,'active') as active;
--down的日志
C = load '$dir3' using PigStorage('`');
CC = foreach C generate  getQueryItem((chararray)$7,'adid')  as adid , getQueryItem((chararray)$7,'project') as project , getQueryItem((chararray)$7,'uid') as uid,getQueryItem((chararray)$7,'mid') as mid,getQueryItem((chararray)$7,'f') as f ,getQueryItem((chararray)$7,'v') as v,getQueryItem((chararray)$7,'s') as s,$0 as ip,getQueryItem((chararray)$7,'hid') as hid,getQueryItem((chararray)$7,'openudid') as openudid,getQueryItem((chararray)$7,'tid') as tuid,getQueryItem((chararray)$7,'active') as active;
CC_filter = filter CC by (adid is not null and  project !='tt');  
CC_all = foreach CC_filter  generate (chararray)uid,(chararray)mid,(chararray)f,(chararray)v,(chararray)s,(chararray)ip,(chararray)hid,(chararray)openudid,(chararray)tuid,(chararray)active;

TJ_union = union BB , TJ_fil, CC_all;
TJ_fil2 = filter TJ_fil by uid is not null;
TJ_group = group TJ_fil2 by (uid,mid,f,v,s,ip,hid,openudid,tuid,active);
TJ_dis = foreach TJ_group generate flatten(group),COUNT(TJ_fil2) as count;
TJ_fix = foreach TJ_dis generate  uid,mid,f,v,s,count,0,0,0,ip,hid,openudid,tuid,active;
STORE TJ_fix into '$output'  using PigStorage('`');
