#!/bin/bash
set -e

mkdir -p .tmp/recorder

COMMIT_ID="bf2696c063b307591483a21693542dd360a3baa6"
BRANCH="main"
COMMIT_ID_SHORT=$(echo "${COMMIT_ID}" | cut -c1-6)

ARCH=amd64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/recorder/kasm_recorder_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_recorder_service/${COMMIT_ID}/kasm_recorder_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

ARCH=arm64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/recorder/kasm_recorder_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_recorder_service/${COMMIT_ID}/kasm_recorder_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

mc cp .tmp/recorder/*.tar.gz aliyun/vscode/kasm/recorder/
