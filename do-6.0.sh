#!/bin/bash

export PATH="$PATH:/usr/local/sbin:/usr/sbin:/sbin"

export HOME="/home/$(whoami)"

cd "$(dirname "$0")"

thepwd="$PWD"

# as in https://redmine.replicant.us/projects/replicant/wiki/Replicant60BuildDependenciesInstallation#Debian-9-stretch
dpkg --add-architecture i386 ; apt-get update
apt-get -y install build-dep gcc binutils llvm-defaults
apt-get -y install aapt android-sdk-build-tools android-sdk-platform-23 ant bash bc ca-cacert cmake curl dirmngr eclipse-jdt gawk gcc-arm-none-eabi git-core g++-multilib gperf gradle lib32ncurses5-dev lib32readline-dev lib32z1-dev libandroidsdk-ddmlib-java libandroidsdk-sdklib-java libasm4-java libc6-dev-i386 libemma-java libfreemarker-java libgmp3-dev libgradle-android-plugin-java libguava-java libmaven-javadoc-plugin-java libmaven-source-plugin-java libmpc-dev libmpfr-dev libnb-org-openide-util-java libnb-platform18-java libncurses-dev lzma lzop maven-debian-helper pngcrush proguard python-dev python-mako rsync schedtool squashfs-tools swig xsltproc zip zlib1g-dev zlib1g-dev:i386

apt-get -y install libmaven-dependency-plugin-java libssl-dev

apt-get -y install default-jdk default-jre

apt-get -y install abootimg

##wget https://download.java.net/openjdk/jdk7u75/ri/openjdk-7u75-b13-linux-x64-18_dec_2014.tar.gz
##tar xvf openjdk-7u75-b13-linux-x64-18_dec_2014.tar.gz

#make some symlinks, required for debian 9
cd /usr/bin
ln -s /bin/grep ./
ln -s /bin/mkdir ./
ln -s /bin/sed ./

#https://redmine.replicant.us/issues/1761
apt-get install locales
/usr/sbin/dpkg-reconfigure locales

cd "$thepwd"

su - live -c "$thepwd/build-6.0.sh"
