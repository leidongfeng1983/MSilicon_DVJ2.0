#!/bin/bash

if [ -d src ]; then
	rm -rf src
fi

if [ -d test/ ]; then
	rm -rf ./test/
fi

if [ -d patches/ ]; then
	rm -rf patches
fi

if [ -d fs_debian_stable/ ]; then
	rm -rf fs_debian_stable
fi

if [ -d ubuntu-18.04.1-console-armhf-2018-09-11 ]; then
	rm -rf ubuntu-18.04.1-console-armhf-2018-09-11
fi

if [ -d ../OK5718-SDK-V1.0 ]; then
	rm -rf ../OK5718-SDK-V1.0
fi

if [ -d ../xenomai-x86 ]; then
	rm -rf ../xenomai-x86
fi

if [ -f patch.sh ]; then
	rm patch.sh
fi

if [ -f prebuild.sh ]; then 
	m prebuild.sh
fi

if [ -f build.sh ]; then
	rm build.sh
fi

if [ -f clean.sh ]; then
	rm clean.sh
fi

if [ -f os ]; then
	rm os
fi

if [ "$1" == "djv" ]; then
	cp -rf OK5718/* ./
elif [ "$1" == "debian" ]; then
	cp -rf debian/* ./
	echo debian>os
elif [ "$1" == "emmc" ]; then
	cp -rf debian/* ./
	echo emmc>os
elif [ "$1" == "ubuntu" ]; then
	cp -rf debian/* ./
	echo ubuntu>os
elif [ "$1" == "ethercat" ]; then
	cp -rf debian/* ./
	echo ethercat>os
elif [ "$1" == "canopen" ]; then
	cp -rf debian/* ./
	echo canopen>os
elif [ "$1" == "xenomai-x86" ]; then
	cp -rf xenomai-x86/* ./
fi


