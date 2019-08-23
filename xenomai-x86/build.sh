#!/bin/bash
XENO_VER=3.0.8
IPIPE_VER=4.9.38-x86-4
KERNEL_VER=4.9.38
PATH_VER=/home/$USER/DJV2.0/xenomai-x86

#other version 
#IPIPE_VER=4.4.43-x86-8 
#KERNEL_VER=4.4.43

cat << EOM

##################################################################################

This script will build a kernel with xenomai and package .deb .

This script must run after prebuild.sh,if you already run prebuild.sh , please ignore this.

Example:
$ ./bulid.sh 
$ ./bulid.sh custom

##################################################################################

EOM

if [ "$#" == 1 -a "$1" == "custom" ]; then
	CUSTOM=1
else
	CUSTOM=0
fi

#SHELL_FOLDER=$(dirname $(readlink -f "$0"))
 
cd $PATH_VER

echo "##############start clean##############" 
echo
# make mrproper
if [ -d linux-$KERNEL_VER ]; then
cd linux-$KERNEL_VER && make mrproper
fi

if [ "$CUSTOM" == 1 ]; then
echo "############# custom model : please make menuconfig by yourself!############"
echo
# copy /boot/config as .config
cp /boot/config-*-generic   .config
# make menuconfig
make menuconfig
else
echo "############# default model : just waiting! ###############################"
echo
cp /home/$USER/DJV2.0/MSilicon_DVJ2.0/pathes/xenomai-x86/linux-4.9.38/defconfig \.config
fi

# make 
echo "############# start making ! just waiting! ################################"
echo
fakeroot make-kpkg --initrd -j4 kernel_image kernel_headers

# install
#cd .. && sudo dpkg -i linux-*.deb

