#!/bin/bash
set -e

mkdir -p .tmp/printer

COMMIT_ID="30ca302fa364051fd4c68982da7c5474a7bda6b8"
BRANCH="develop"
COMMIT_ID_SHORT=$(echo "${COMMIT_ID}" | cut -c1-6)

ARCH=amd64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/printer/kasm_printer_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_printer_service/${COMMIT_ID}/kasm_printer_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

ARCH=arm64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/printer/kasm_printer_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_printer_service/${COMMIT_ID}/kasm_printer_service_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

mc cp .tmp/printer/*.tar.gz aliyun/vscode/kasm/printer/
