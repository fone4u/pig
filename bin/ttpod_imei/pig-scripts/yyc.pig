--param : date 
SET default_parallel 3;
rmf $output;
register /usr/lib/pig/piggybank.jar;
register /usr/lib/pig/pig-udf-ttpod-stat.jar;
define getQueryItem com.ttpod.stat.exec.url.GetItemFromQueryString();
A = load '/pig/tmp/ttpod_client.$date.gz'  using PigStorage('`') as (ip:chararray,data:map[],param:map[]);
GETKEY = foreach A generate data#'module' as module,data#'type' as type,data#'origin' as origin,param#'uid' as uid,param#'mid' as mid,param#'f' as f,param#'v' as v,param#'s' as s,ip ,param#'hid' as hid,param#'openudid' as openudid,param#'tid' as tuid,param#'active' as active;
YYC_json = filter GETKEY by (module=='sway') or (module=='musicCircle') or (module=='song' and type=='listen_info') or (module=='page' and (type=='online' or type=='search')) or (module=='download' and type=='song');
YYC_json_fil= foreach YYC_json  generate (chararray)uid,(chararray)mid,(chararray)f,(chararray)v,(chararray)s,(chararray)ip,(chararray)hid,(chararray)openudid,(chararray)tuid,(chararray)active;

B = load '/logdata/yycv1/$date' using PigStorage('`');
BB = foreach B generate getQueryItem((chararray)$7,'uid') as uid,getQueryItem((chararray)$7,'mid') as mid,getQueryItem((chararray)$7,'f') as f ,getQueryItem((chararray)$7,'v') as v,getQueryItem((chararray)$7,'s') as s,$0 as ip,getQueryItem((chararray)$7,'hid') as hid,getQueryItem((chararray)$7,'openudid') as openudid,getQueryItem((chararray)$7,'tid') as tuid,getQueryItem((chararray)$7,'active') as active;

C = load '/logdata/down/$date' using PigStorage('`');
CC = foreach C generate getQueryItem((chararray)$7,'adid') as adid,getQueryItem((chararray)$7,'uid') as uid,getQueryItem((chararray)$7,'mid') as mid,getQueryItem((chararray)$7,'f') as f ,getQueryItem((chararray)$7,'v') as v,getQueryItem((chararray)$7,'s') as s,$0 as ip,getQueryItem((chararray)$7,'hid') as hid,getQueryItem((chararray)$7,'openudid') as openudid,getQueryItem((chararray)$7,'tid') as tuid,getQueryItem((chararray)$7,'active') as active;
CC_fil = filter CC by  adid is not null;
CC_fix = foreach CC_fil generate  uid,mid,f,v,s,ip,hid,openudid,tuid,active;


YYC_all = union  YYC_json_fil , BB , CC_fix ;
YYC_fil1 = filter YYC_all by uid is not null;
SPLIT  YYC_fil1  into YYC_ios  IF  (s matches 's3.*'), YYC_other  OTHERWISE;
YYC_ios_foreach = foreach YYC_ios generate hid as uid,mid,f,v,s,ip,uid as hid,openudid,tuid,active;

YYC_union = union YYC_ios,  YYC_other;

YYC_group = group YYC_union by (uid,mid,f,v,s,ip,hid,openudid,tuid,active);
YYC_count = foreach YYC_group generate flatten(group),COUNT(YYC_union) as count;
YYC_fix = foreach YYC_count generate  uid,mid,f,v,s,count,0,0,0,ip,hid,openudid,tuid,active;
STORE YYC_fix into '$output'  using PigStorage('`');
