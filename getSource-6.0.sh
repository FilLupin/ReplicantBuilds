#!/bin/bash

putInConfig(){
if [ "${3}" = "" ]; then 
	theresult="y"
else
	theresult="${3}"
fi
	if [ "$(grep "^${1}=n" ${2})" != "" ]; then
		sed -i "s/${1}=n/${1}=${theresult}/g" ${2}
	elif [ "$(grep "^# ${1} is not set" ${2})" != "" ]; then
		sed -i "s/# ${1} is not set/${1}=${theresult}/g" "${2}"
	elif [ "$(grep "^${1}=m" ${2})" != "" ]; then
		sed -i "s/${1}=m/${1}=${theresult}/g" "${2}"
	elif [ "$(grep "^${1}=${theresult}" ${2})" = "" ]; then
		echo "${1}=${theresult}" >> "${2}"
	fi
}


takeFromConfig(){
	if [ "$(grep "^${1}=y" ${2})" != "" ]; then
		sed -i "s/${1}=y/${1}=n/g" ${2}
	elif [ "$(grep "^# ${1} is not set" ${2})" != "" ]; then
		sed -i "s/# ${1} is not set/${1}=n/g" "${2}"
	elif [ "$(grep "^${1}=m" ${2})" != "" ]; then
		sed -i "s/${1}=n/${1}=y/g" "${2}"
	elif [ "$(grep "^${1}=n" ${2})" = "" ]; then
		echo "${1}=n" >> "${2}"
	fi
}

export HOME="/home/$(whoami)"

cd "$(dirname "$0")"

thepwd="${PWD}"

REPLICANTDIR="${PWD}/replicant-6.0"

printf "This will require ~140GB\n"

#starts here

#use system certificates
export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

#source /usr/local/bin/repo-env.sh

mkdir replicant-6.0
cd replicant-6.0

git config --global user.email "dontcall@me.com"
git config --global user.name "Absolutely Anonymous"

while true; do
	git clone https://git.replicant.us/replicant/manifest.git -b replicant-6.0 manifest
	if [ "$?" = "0" ]; then
		break
	else
		if [ -d manifest ]; then
			rm -rf manifest
		fi
		sleep 60
	fi
done

cd manifest

#fix broken links in manifest
patch -p0 < ../../patches/vanilla_replicant_default.xml.patch

cd ..


mkdir -p "${thepwd}/replicantMirror"

#mirror the sources
${thepwd}/reapz-download.sh reconstructmirror "${REPLICANTDIR}/manifest/default.xml" "${thepwd}/replicantMirror"

#clone from bare git to working git
${thepwd}/reapz-download.sh processsources "${REPLICANTDIR}/manifest/default.xml" "${thepwd}/replicantMirror" "${REPLICANTDIR}"

thedir="$PWD"


#get fdroid prebuilt apps
gpg --keyserver keys.gnupg.net --recv-key 37D2C98789D8311948394E3E41E7044E1DBA2E89
vendor/replicant/get-prebuilts


###	cd "${REPLICANTDIR}"
###
####generic (scintill) replicant 6.0 patches {
###
###	#fix tinyalsa error {
###		cd "${REPLICANTDIR}/external/tinyalsa"
###		patch -p0 < ../../../patches/external_tinyalsa_pcm.c.patch
###	#fix tinyalsa error }
###
###	#https://android.googlesource.com/platform/bionic/+/6f88821e5dc4894dc2905cbe53ae21c782354f38%5E%21/ {
###		cd "${REPLICANTDIR}/bionic"
###		patch -p0 < ../../patches/uchar.h.patch
###
###	#https://android.googlesource.com/platform/bionic/+/6f88821e5dc4894dc2905cbe53ae21c782354f38%5E%21/ }
###
####generic (scintill) replicant 6.0 patches }