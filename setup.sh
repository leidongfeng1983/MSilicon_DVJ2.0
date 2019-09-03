#!/bin/bash

rm -rf src
rm -rf test
rm -rf patches
rm -rf fs_debian_stable
rm -rf ubuntu-18.04.1-console-armhf-2018-09-11
rm -rf ../OK5718-SDK-V1.0
rm -rf ../xenomai-x86
rm patch.sh 
rm prebuild.sh
rm build.sh
rm clean.sh

if [ "$1" == "djv" ]; then
	cp -rf OK5718/* ./
elif [ "$1" == "debian" ]; then
	cp -rf debian/* ./
elif [ "$1" == "emmc" ]; then
	cp -rf emmc/* ./
elif [ "$1" == "ubuntu" ]; then
	cp -rf ubuntu/* ./
elif [ "$1" == "ethercat" ]; then
	cp -rf ethercat/* ./
elif [ "$1" == "canopen" ]; then
	cp -rf canopen/* ./
elif [ "$1" == "xenomai-x86" ]; then
	cp -rf xenomai-x86/* ./
fi


