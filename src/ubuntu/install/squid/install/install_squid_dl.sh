#!/bin/bash
set -e

mkdir -p .tmp/squid

SQUID_COMMIT='1149fc830c7edcb383eec390cce2beba16befde5'

COMMIT_ID="f8a1049969e7bde2fa0814eb3e5e09f4359efca1"
BRANCH="develop"
COMMIT_ID_SHORT=$(echo "${COMMIT_ID}" | cut -c1-6)

ARCH=amd64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/squid/kasm-squid-builder_${ARCH}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm-squid-builder/${SQUID_COMMIT}/output/kasm-squid-builder_${ARCH}.tar.gz
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/squid/kasm_squid_adapter_glibc_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_squid_adapter/${COMMIT_ID}/kasm_squid_adapter_glibc_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

ARCH=arm64
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/squid/kasm-squid-builder_${ARCH}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm-squid-builder/${SQUID_COMMIT}/output/kasm-squid-builder_${ARCH}.tar.gz
curl -x $SOCKS5_PROXY_LOCAL \
  -o .tmp/squid/kasm_squid_adapter_glibc_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz \
  -fL https://kasmweb-build-artifacts.s3.amazonaws.com/kasm_squid_adapter/${COMMIT_ID}/kasm_squid_adapter_glibc_${ARCH}_${BRANCH}.${COMMIT_ID_SHORT}.tar.gz

mc cp .tmp/squid/*.tar.gz aliyun/vscode/kasm/squid/
