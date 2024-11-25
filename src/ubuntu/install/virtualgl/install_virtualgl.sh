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
    # opengl base: https://gitlab.com/nvidia/container-images/opengl/-/blob/ubuntu20.04/base/Dockerfile
    apt-get update && apt-get install -y --no-install-recommends \
      libxau6 libxau6:i386 \
      libxdmcp6 libxdmcp6:i386 \
      libxcb1 libxcb1:i386 \
      libxext6 libxext6:i386 \
      libx11-6 libx11-6:i386
    # opengl runtime: https://gitlab.com/nvidia/container-images/opengl/-/blob/ubuntu20.04/glvnd/runtime/Dockerfile
    apt-get update && apt-get install -y --no-install-recommends \
      libglvnd0 libglvnd0:i386 \
      libgl1 libgl1:i386 \
      libglx0 libglx0:i386 \
      libegl1 libegl1:i386 \
      libgles2 libgles2:i386
    # hardware accleration utilities
    apt-get update && apt-get install -y --no-install-recommends \
      libglu1 libglu1:i386 \
      libvulkan-dev libvulkan-dev:i386 \
      mesa-utils mesa-utils-extra \
      mesa-va-drivers mesa-vulkan-drivers \
      vainfo vdpauinfo vulkan-tools

    VULKAN_API_VERSION=$(dpkg -s libvulkan1 | grep -oP 'Version: [0-9|\.]+' | grep -oP '[0-9]+(\.[0-9]+)(\.[0-9]+)')
    mkdir -p /etc/vulkan/icd.d/ &&
      echo "{\n\
    \"file_format_version\" : \"1.0.0\",\n\
    \"ICD\": {\n\
        \"library_path\": \"libGLX_nvidia.so.0\",\n\
        \"api_version\" : \"${VULKAN_API_VERSION}\"\n\
    }\n\
}" >/etc/vulkan/icd.d/nvidia_icd.json

    if ! grep -q "24.04" /etc/os-release; then
      add-apt-repository ppa:kisak/turtle
      sed -i 's/ppa.launchpadcontent.net/launchpad.proxy.ustclug.org/g' /etc/apt/sources.list /etc/apt/sources.list.d/*.list
      apt full-upgrade -y
    fi
    curl -o $INST_SCRIPTS/virtualgl/virtualgl_${BUILD_VERSION}_amd64.deb -fL https://cache.ali.wodcloud.com/vscode/kasm/virtualgl/virtualgl_${BUILD_VERSION}_amd64.deb
    curl -o $INST_SCRIPTS/virtualgl/virtualgl32_${BUILD_VERSION}_amd64.deb -fL https://cache.ali.wodcloud.com/vscode/kasm/virtualgl/virtualgl32_${BUILD_VERSION}_amd64.deb
    apt-get install -y --no-install-recommends $INST_SCRIPTS/virtualgl/virtualgl_*amd64.deb $INST_SCRIPTS/virtualgl/virtualgl32_*amd64.deb
  fi

  chmod u+s /usr/lib/libvglfaker.so
  chmod u+s /usr/lib/libdlfaker.so
  chmod u+s /usr/lib32/libvglfaker.so
  chmod u+s /usr/lib32/libdlfaker.so
  chmod u+s /usr/lib/i386-linux-gnu/libvglfaker.so
  chmod u+s /usr/lib/i386-linux-gnu/libdlfaker.so

  apt-get clean -y
  rm -rf $INST_SCRIPTS/virtualgl/
fi
