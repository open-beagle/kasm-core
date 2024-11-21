#!/usr/bin/env bash

BUILD_ARCH=$(arch | sed 's/aarch64/arm64/g' | sed 's/x86_64/amd64/g')
BUILD_VERSION="3.1"

rm -rf $INST_SCRIPTS/virtualgl/*.deb
if [[ "$DISTRO" = @(ubuntu|debian) ]]; then

  if [[ "${BUILD_ARCH}" = "arm64" ]]; then
    apt-get update && apt-get install -y --no-install-recommends \
      libxau6 libxdmcp6 libxcb1 libxext6 libx11-6
    apt-get update && apt-get install -y --no-install-recommends \
      libglvnd0 libgl1 libglx0 libegl1 libgles2 libegl1-mesa

    curl -o $INST_SCRIPTS/virtualgl/virtualgl_${BUILD_VERSION}_arm64.deb -fL https://cache.ali.wodcloud.com/vscode/kasm/virtualgl/virtualgl_${BUILD_VERSION}_arm64.deb
    dpkg -i $INST_SCRIPTS/virtualgl/virtualgl_*arm64.deb
  else
    dpkg --add-architecture i386
    apt-get update && apt-get install -y --no-install-recommends \
      libxau6 libxau6:i386 \
      libxdmcp6 libxdmcp6:i386 \
      libxcb1 libxcb1:i386 \
      libxext6 libxext6:i386 \
      libx11-6 libx11-6:i386
    apt-get update && apt-get install -y --no-install-recommends \
      libglvnd0 libglvnd0:i386 \
      libgl1 libgl1:i386 \
      libglx0 libglx0:i386 \
      libegl1 libegl1:i386 \
      libgles2 libgles2:i386 \
      libegl1-mesa libegl1-mesa:i386

    if ! grep -q "24.04" /etc/os-release; then
      add-apt-repository ppa:kisak/turtle
      apt full-upgrade -y
    fi
    curl -o $INST_SCRIPTS/virtualgl/virtualgl_${BUILD_VERSION}_amd64.deb -fL https://cache.ali.wodcloud.com/vscode/kasm/virtualgl/virtualgl_${BUILD_VERSION}_amd64.deb
    dpkg -i $INST_SCRIPTS/virtualgl/virtualgl_*amd64.deb
  fi

  apt install -f -y
  rm -rf $INST_SCRIPTS/virtualgl/
fi
