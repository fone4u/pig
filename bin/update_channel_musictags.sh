#!/bin/sh
#author :chenxin.wen
#date :2013-05-24


#hadoop fs -rm -r -skipTrash /var/database/channel;
#sqoop import --connect jdbc:mysql://117.135.147.112/tt5 --username 'ttpodselect' --password 'ttpodselect!@#'  --table channel --target-dir /var/database/channel -m 1 --columns id,parentId,channelName

hadoop fs -rm -r -skipTrash /var/database/music_tags;
sqoop import --connect jdbc:mysql://117.135.151.123/music --username 'radio' --password 'ttpod123'  --table music_tags --target-dir /var/database/music_tags -m 1 --columns tag_id,tag_type_id,tag_name
