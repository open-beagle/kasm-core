#!/bin/bash
set -e

mkdir -p .tmp/audio

ARCH=amd64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/audio/kasm_websocket_relay_${ARCH}_develop.f7efb8.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_websocket_relay/f7efb82dc59a02d1b99e2e2b3c6d127dc548ba72/kasm_websocket_relay_${ARCH}_develop.f7efb8.tar.gz

ARCH=arm64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/audio/kasm_websocket_relay_${ARCH}_develop.f7efb8.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_websocket_relay/f7efb82dc59a02d1b99e2e2b3c6d127dc548ba72/kasm_websocket_relay_${ARCH}_develop.f7efb8.tar.gz

mc cp .tmp/audio/*.tar.gz aliyun/vscode/kasm/audio/
