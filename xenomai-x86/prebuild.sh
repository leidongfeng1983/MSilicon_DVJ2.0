#!/bin/bash
XENO_VER=3.0.8
IPIPE_VER=4.9.38-x86-4
KERNEL_VER=4.9.38
PATH_VER=/home/$USER/DJV2.0/xenomai-x86

#other version 
#IPIPE_VER=4.4.43-x86-8 
#KERNEL_VER=4.4.43

# kernel nessary
sudo apt-get install gcc kernel-package libc6-dev tk8.6 libncurses5-dev fakeroot bin86 libssl-dev build-essential

# linuxcnc nessary
#sudo apt-get install libudev-dev libmodbus-dev libusb-1.0-0-dev \
#        libglib2.0-dev libgtk2.0-dev yapps2 intltool tcl8.4-dev tk8.4-dev \
#       bwidget libtk-img libtk-img-dev tclx8.4-dev python-gtk2 \
#       python-tk libreadline-gplv2-dev libboost-python-dev \
#       libgl1-mesa-dev libglu1-mesa-dev libxmu-dev python-gi

#get in /home/$(USER)/xenomai 

if [ ! -d $PATH_VER ]; then
mkdir -p $PATH_VER
fi
cd $PATH_VER

# Fetch xenomai
if [ ! -f  $PATH_VER/xenomai-$XENO_VER.tar.bz2 ]; then
wget https://xenomai.org/downloads/xenomai/stable/xenomai-$XENO_VER.tar.bz2
fi

# Fetch ipipe
if [ ! -f  $PATH_VER/ipipe-core-$IPIPE_VER.patch ]; then
wget https://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-$IPIPE_VER.patch
fi

# Fetch kernel
if [ ! -f $PATH_VER/linux-$KERNEL_VER.tar.gz ]; then
wget https://mirrors.aliyun.com/linux-kernel/v4.x/linux-$KERNEL_VER.tar.gz
#wget https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/linux-$KERNEL_VER.tar.gz 
fi

if [ ! -d  $PATH_VER/xenomai-$XENO_VER ]; then
tar xjf xenomai-$XENO_VER.tar.bz2
fi

if [ ! -d $PATH_VER/linux-$KERNEL_VER ]; then
tar xf linux-$KERNEL_VER.tar.gz
fi

# Patch kernel
$PATH_VER/xenomai-$XENO_VER/scripts/prepare-kernel.sh --linux=$PATH_VER/linux-$KERNEL_VER --ipipe=$PATH_VER/ipipe-core-$IPIPE_VER.patch --arch=x86
