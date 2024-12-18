#!/bin/bash
set -e

# Icon list to ingest
IFS=$'\n'
icons='https://cache.ali.wodcloud.com/vscode/kasm/emblems/s3.svg|s3
https://cache.ali.wodcloud.com/vscode/kasm/emblems/nextcloud.svg|nextcloud
https://cache.ali.wodcloud.com/vscode/kasm/emblems/onedrive.svg|onedrive
https://cache.ali.wodcloud.com/vscode/kasm/emblems/gdrive.svg|gdrive
https://cache.ali.wodcloud.com/vscode/kasm/emblems/dropbox.svg|dropbox
https://cache.ali.wodcloud.com/vscode/kasm/emblems/kasm.svg|kasm'

# Download icons and add to cache
mkdir -p /usr/share/icons/hicolor/scalable/emblems
for icon in $icons; do
  URL=$(echo "${icon}" | awk -F'|' '{print $1}')
  NAME=$(echo "${icon}" | awk -F'|' '{print $2}')
  curl -o /usr/share/icons/hicolor/scalable/emblems/${NAME}-emblem.svg -fL "${URL}"
  echo "[Icon Data]" >> /usr/share/icons/hicolor/scalable/emblems/${NAME}-emblem.icon
  echo "DisplayName=${NAME}-emblem" >> /usr/share/icons/hicolor/scalable/emblems/${NAME}-emblem.icon
done
gtk-update-icon-cache -f /usr/share/icons/hicolor

# Support dynamic icons on init
cat >>/etc/xdg/autostart/emblems.desktop<<EOL
[Desktop Entry]
Type=Application
Name=Folder Emblems
Exec=/dockerstartup/emblems.sh
EOL
chmod +x /etc/xdg/autostart/emblems.desktop
