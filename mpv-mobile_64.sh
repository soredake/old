#!/bin/bash

sudo docker run -it -v "$HOME/Documents/mpv-android":/build debian:stable bash -c '
apt update
# https://github.com/mpv-android/buildscripts/issues/5
apt install -y sudo git wget apt-utils default-jdk unzip python build-essential automake
git clone https://github.com/mpv-android/mpv-android
cd mpv-android/buildscripts
# https://github.com/mpv-android/buildscripts/issues/4#issuecomment-310817217
sed -i -e "s/apt-get/apt-get -y/g" -e "s/'"'./android-sdk/echo \'y\' | '"'./android-sdk/g" include/download-sdk.sh
cd buildscripts
./download.sh
sed -i -e 's/APP_ABI := armeabi-v7a//g' ../app/src/main/jni/Application.mk || exit 1
./buildall.sh --arch x86 || exit 1
cp ../app/build/outputs/apk/app-debug.apk /build
'