#!/bin/bash
set -e

# Icon list to ingest
IFS=$'\n'
icons='https://upload.wikimedia.org/wikipedia/commons/b/bc/Amazon-S3-Logo.svg|s3
https://upload.wikimedia.org/wikipedia/commons/6/60/Nextcloud_Logo.svg|nextcloud
https://upload.wikimedia.org/wikipedia/commons/3/3c/Microsoft_Office_OneDrive_%282019%E2%80%93present%29.svg|onedrive
https://upload.wikimedia.org/wikipedia/commons/1/12/Google_Drive_icon_%282020%29.svg|gdrive
https://upload.wikimedia.org/wikipedia/commons/7/78/Dropbox_Icon.svg|dropbox
https://kasm-ci.s3.amazonaws.com/kasm.svg|kasm'

# Download icons and add to cache
mkdir -p .tmp/emblems
for icon in $icons; do
  URL=$(echo "${icon}" | awk -F'|' '{print $1}')
  NAME=$(echo "${icon}" | awk -F'|' '{print $2}')
  curl -o .tmp/emblems/${NAME}.svg -x $SOCKS5_PROXY_LOCAL -sfL "${URL}"
done

mc cp .tmp/emblems/*.svg aliyun/vscode/kasm/emblems/
