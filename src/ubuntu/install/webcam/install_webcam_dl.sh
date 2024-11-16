#!/bin/bash
set -e

mkdir -p .tmp/webcam

COMMIT_ID="23df7e27fe5c1536bd08da6bd58d65d1d7facb1b"
BRANCH="develop"
COMMIT_ID_SHORT=$(echo "${COMMIT_ID}" | cut -c1-6)

ARCH=amd64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/webcam/kasm_webcam_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_webcam_server/${COMMIT_ID}/kasm_webcam_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

ARCH=arm64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/webcam/kasm_webcam_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_webcam_server/${COMMIT_ID}/kasm_webcam_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

mc cp .tmp/webcam/*.tar.gz aliyun/vscode/kasm/webcam/
