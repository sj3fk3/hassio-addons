#!/bin/bash
set -e

echo "[Info] Starting Hass.io folder rsync docker container!"

CONFIG_PATH=/data/options.json
rsyncserver=$(jq --raw-output ".rsyncserver" $CONFIG_PATH)
rootfolder=$(jq --raw-output ".rootfolder" $CONFIG_PATH)
username=$(jq --raw-output ".username" $CONFIG_PATH)
password=$(jq --raw-output ".password" $CONFIG_PATH)

rsyncurl="$username@$rsyncserver::$rootfolder"

echo "[Info] trying to rsync hassio media folders to $rsyncurl"
echo ""
echo "[Info] /config/www"
sshpass -p $password rsync -avt  /config/www $rsyncurl/www/ 
if [ -d "/media" ]; then
 echo ""
 echo "[Info] /media"
 sshpass -p $password rsync -avt /media/ $rsyncurl/media/
else 
 echo ""
 echo "[Info] /media not existing"
fi
echo "[Info] Finished rsync"
