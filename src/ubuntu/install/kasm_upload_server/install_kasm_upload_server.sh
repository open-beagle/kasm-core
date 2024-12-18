#!/usr/bin/env bash
set -ex

COMMIT_ID="b234364fdef2dc96ac106ac5e4350c86c1f45021"
BRANCH="develop"
COMMIT_ID_SHORT=$(echo "${COMMIT_ID}" | cut -c1-6)

ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/amd64/g')

mkdir $STARTUPDIR/upload_server
curl -fL https://cache.ali.wodcloud.com/vscode/kasm/kasm_upload_server/kasm_upload_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz -o /tmp/kasm_upload_server.tar.gz
tar -xvf /tmp/kasm_upload_server.tar.gz -C $STARTUPDIR/upload_server
rm /tmp/kasm_upload_server.tar.gz
echo "${BRANCH}:${COMMIT_ID}" > $STARTUPDIR/upload_server/kasm_upload_service.version
