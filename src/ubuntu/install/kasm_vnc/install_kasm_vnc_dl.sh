#!/bin/bash
set -e

mkdir -p .tmp/kasm_vnc

COMMIT_ID="6c368aa746bf16bab692535597e1d031affc7c77"
BRANCH="release"
COMMIT_ID_SHORT=$(echo "${COMMIT_ID}" | cut -c1-6)

KASMVNC_VER="1.3.2"
# Naming scheme is now different between an official release and feature branch
KASM_VER_NAME_PART="${KASMVNC_VER}_${BRANCH}_${COMMIT_ID_SHORT}"
if [[ "${BRANCH}" == "release" ]]; then
  KASM_VER_NAME_PART="${KASMVNC_VER}"
fi

ARCH=amd64
echo https://kasmweb-build-artifacts.s3.amazonaws.com/kasmvnc/${COMMIT_ID}/kasmvncserver_bookworm_${KASM_VER_NAME_PART}_${ARCH}.deb
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/kasm_vnc/kasmvncserver_bookworm_${KASM_VER_NAME_PART}_${ARCH}.deb \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasmvnc/${COMMIT_ID}/kasmvncserver_bookworm_${KASM_VER_NAME_PART}_${ARCH}.deb

ARCH=arm64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/kasm_vnc/kasmvncserver_bookworm_${KASM_VER_NAME_PART}_${ARCH}.deb \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasmvnc/${COMMIT_ID}/kasmvncserver_bookworm_${KASM_VER_NAME_PART}_${ARCH}.deb

UBUNTU_CODENAME=jammy
ARCH=amd64
echo https://kasmweb-build-artifacts.s3.amazonaws.com/kasmvnc/${COMMIT_ID}/kasmvncserver_${UBUNTU_CODENAME}_${KASM_VER_NAME_PART}_${ARCH}.deb
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/kasm_vnc/kasmvncserver_${UBUNTU_CODENAME}_${KASM_VER_NAME_PART}_${ARCH}.deb \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasmvnc/${COMMIT_ID}/kasmvncserver_${UBUNTU_CODENAME}_${KASM_VER_NAME_PART}_${ARCH}.deb

ARCH=arm64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/kasm_vnc/kasmvncserver_${UBUNTU_CODENAME}_${KASM_VER_NAME_PART}_${ARCH}.deb \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasmvnc/${COMMIT_ID}/kasmvncserver_${UBUNTU_CODENAME}_${KASM_VER_NAME_PART}_${ARCH}.deb

mc cp .tmp/kasm_vnc/*.deb aliyun/vscode/kasm/kasm_vnc/
