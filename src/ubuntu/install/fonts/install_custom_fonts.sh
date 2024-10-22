#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

LOCALES_RHEL="glibc-langpack-en glibc-langpack-zh"

LOCALES_UBUNTU="language-pack-en language-pack-zh-hans"

LOCALES="en_US zh_CN"

echo "Installing fonts and languages"
if [[ "${DISTRO}" == "oracle7" ]]; then
  yum-config-manager --enable ol7_optional_latest
  yum install -y \
    google-noto-emoji-fonts \
    google-noto-sans-cjk-fonts \
    google-noto-sans-fonts 
elif [[ "${DISTRO}" == "centos" ]]; then
  yum install -y \
    google-noto-emoji-fonts \
    google-noto-sans-cjk-fonts \
    google-noto-sans-fonts 
elif [[ "${DISTRO}" == @(fedora37|fedora38|fedora39|fedora40) ]]; then
  dnf install -y \
    glibc-locale-source \
    google-noto-cjk-fonts \
    google-noto-emoji-fonts \
    google-noto-sans-fonts \
    ${LOCALES_RHEL}
  for LOCALE in ${LOCALES}; do
    echo "Generating Locale for ${LOCALE}"
    localedef -i ${LOCALE} -f UTF-8 ${LOCALE}.UTF-8
  done
elif [[ "${DISTRO}" == @(oracle8|oracle9|rockylinux9|rockylinux8|almalinux9|almalinux8) ]]; then
  dnf install -y \
    glibc-locale-source \
    google-noto-emoji-fonts \
    google-noto-sans-cjk-ttc-fonts \
    google-noto-sans-fonts \
    ${LOCALES_RHEL}
  for LOCALE in ${LOCALES}; do
    echo "Generating Locale for ${LOCALE}"
    localedef -i ${LOCALE} -f UTF-8 ${LOCALE}.UTF-8
  done
elif [ "${DISTRO}" == "opensuse" ]; then
  zypper addrepo -G \
    https://download.opensuse.org/repositories/M17N:/fonts/15.5/ fonts-x86_64
  zypper install -ny \
    glibc-i18ndata \
    glibc-locale \
    google-noto-coloremoji-fonts \
    google-noto-sans-cjk-fonts \
    noto-sans-fonts
  for LOCALE in ${LOCALES}; do
    echo "Generating Locale for ${LOCALE}"
    localedef -i ${LOCALE} -f UTF-8 ${LOCALE}.UTF-8
  done
elif [ "${DISTRO}" == "alpine" ]; then
  apk add --no-cache \
    font-noto-all \
    font-noto-cjk \
    font-noto-emoji
elif [[ "${DISTRO}" == @(debian|parrotos6|kali) ]]; then
  apt-get update
  apt-get install -y \
    fonts-noto-core \
    fonts-noto-cjk \
    fonts-noto-color-emoji \
    locales-all
  for LOCALE in ${LOCALES}; do
    echo "Generating Locale for ${LOCALE}"
    localedef -i ${LOCALE} -f UTF-8 ${LOCALE}.UTF-8
  done
elif $(grep -q Bionic /etc/os-release); then
  apt-get update
  apt-get install -y \
    fonts-noto-cjk \
    fonts-noto-color-emoji \
    fonts-noto-hinted \
    fonts-noto-unhinted \
    ${LOCALES_UBUNTU}
else
  apt-get update
  apt-get install -y \
    fonts-noto-core \
    fonts-noto-cjk \
    fonts-noto-color-emoji \
    ${LOCALES_UBUNTU}
fi
