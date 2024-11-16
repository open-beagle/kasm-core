#!/bin/bash
set -e

mkdir -p .tmp/gamepad

COMMIT_ID="ab327e308e000ddff2e5020a4a66e1fe4935d380"
BRANCH="develop"
COMMIT_ID_SHORT=$(echo "${COMMIT_ID}" | cut -c1-6)

ARCH=amd64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/gamepad/kasm_gamepad_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_gamepad_server/${COMMIT_ID}/kasm_gamepad_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

ARCH=arm64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/gamepad/kasm_gamepad_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_gamepad_server/${COMMIT_ID}/kasm_gamepad_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

mc cp .tmp/gamepad/*.tar.gz aliyun/vscode/kasm/gamepad/
