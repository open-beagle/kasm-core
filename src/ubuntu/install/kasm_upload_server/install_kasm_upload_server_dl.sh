#!/bin/bash
set -e

mkdir -p .tmp/kasm_upload_server

COMMIT_ID="b234364fdef2dc96ac106ac5e4350c86c1f45021"
BRANCH="develop"
COMMIT_ID_SHORT=$(echo "${COMMIT_ID}" | cut -c1-6)

ARCH=amd64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/kasm_upload_server/kasm_upload_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_upload_service/${COMMIT_ID}/kasm_upload_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

ARCH=arm64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/kasm_upload_server/kasm_upload_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_upload_service/${COMMIT_ID}/kasm_upload_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

mc cp .tmp/kasm_upload_server/*.tar.gz aliyun/vscode/kasm/kasm_upload_server/
