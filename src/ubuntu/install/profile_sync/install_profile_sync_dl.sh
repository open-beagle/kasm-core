#!/bin/bash
set -e

detect_deb_distro() {
  local distro
  local codename
  local full_name

  distro=$(grep -Po -m 1 '(?<=PRETTY_NAME=")[^ ]+' /etc/os-release)
  codename=$(grep -Po -m 1 "(?<=_CODENAME=)\w+" /etc/os-release)
  full_name="${distro}_${codename}"
  echo "${full_name,,}"
}

mkdir -p .tmp/profile_sync

COMMIT_ID="42424ea385a0d10fa7bb5749e207ee70b2a44ae2"
BRANCH="develop"
COMMIT_ID_SHORT=$(echo "${COMMIT_ID}" | cut -c1-6)

profile_distro="debian_bookworm"

echo $profile_distro

ARCH=x86_64
BINARY_NAME="${profile_distro}_${BRANCH}_${COMMIT_ID_SHORT}_${ARCH}-kasm-profile-sync"
BUILD_URL="https://kasmweb-build-artifacts.s3.amazonaws.com/profile-sync/${COMMIT_ID}/${BINARY_NAME}"
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/profile_sync/${BINARY_NAME} \
  -fL ${BUILD_URL}

ARCH=aarch64
BINARY_NAME="${profile_distro}_${BRANCH}_${COMMIT_ID_SHORT}_${ARCH}-kasm-profile-sync"
BUILD_URL="https://kasmweb-build-artifacts.s3.amazonaws.com/profile-sync/${COMMIT_ID}/${BINARY_NAME}"
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/profile_sync/${BINARY_NAME} \
  -fL ${BUILD_URL}

profile_distro="ubuntu_jammy"

echo $profile_distro

ARCH=x86_64
BINARY_NAME="${profile_distro}_${BRANCH}_${COMMIT_ID_SHORT}_${ARCH}-kasm-profile-sync"
BUILD_URL="https://kasmweb-build-artifacts.s3.amazonaws.com/profile-sync/${COMMIT_ID}/${BINARY_NAME}"
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/profile_sync/${BINARY_NAME} \
  -fL ${BUILD_URL}

ARCH=aarch64
BINARY_NAME="${profile_distro}_${BRANCH}_${COMMIT_ID_SHORT}_${ARCH}-kasm-profile-sync"
BUILD_URL="https://kasmweb-build-artifacts.s3.amazonaws.com/profile-sync/${COMMIT_ID}/${BINARY_NAME}"
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/profile_sync/${BINARY_NAME} \
  -fL ${BUILD_URL}

mc cp .tmp/profile_sync/* aliyun/vscode/kasm/profile_sync/
