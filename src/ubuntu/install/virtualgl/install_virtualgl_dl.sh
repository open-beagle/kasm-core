#!/bin/bash
set -e

mkdir -p .tmp/virtualgl

BUILD_VERSION="3.1"

ARCH=amd64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/virtualgl/virtualgl_${BUILD_VERSION}_${ARCH}.deb \
  -fL https://phoenixnap.dl.sourceforge.net/project/virtualgl/${BUILD_VERSION}/virtualgl_${BUILD_VERSION}_${ARCH}.deb
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/virtualgl/virtualgl32_${BUILD_VERSION}_${ARCH}.deb \
  -fL https://phoenixnap.dl.sourceforge.net/project/virtualgl/${BUILD_VERSION}/virtualgl32_${BUILD_VERSION}_${ARCH}.deb

ARCH=arm64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/virtualgl/virtualgl_${BUILD_VERSION}_${ARCH}.deb \
  -fL https://phoenixnap.dl.sourceforge.net/project/virtualgl/${BUILD_VERSION}/virtualgl_${BUILD_VERSION}_${ARCH}.deb

mc cp .tmp/virtualgl/*.deb aliyun/vscode/kasm/virtualgl/
