#!/bin/bash
set -e

mkdir -p .tmp/audio_input

COMMIT_ID="82d11b74e05be5175cd4096ad6463f83ded1f532"
BRANCH="develop"
COMMIT_ID_SHORT=$(echo "${COMMIT_ID}" | cut -c1-6)

ARCH=amd64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/audio_input/kasm_audio_input_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_audio_input_server/${COMMIT_ID}/kasm_audio_input_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

ARCH=arm64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/audio_input/kasm_audio_input_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_audio_input_server/${COMMIT_ID}/kasm_audio_input_server_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

mc cp .tmp/audio_input/*.tar.gz aliyun/vscode/kasm/audio_input/
