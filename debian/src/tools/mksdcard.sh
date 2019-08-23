#! /bin/bash
# Script to create SD card for 572x plaform.
#
# Author: Brijesh Singh, Texas Instruments Inc.
#
# Licensed under terms of GPLv2

VERSION="0.4"

if [ "$#" == 1 -a "$1" == "recover" ]; then
	RECOVER=1
else
	RECOVER=0
fi

execute ()
{
	$* >/dev/null
	if [ $? -ne 0 ]; then
		echo
		echo "ERROR: executing $*"
		echo
		exit 1
	fi
}

#clear
cat << EOM

################################################################################

This script will create a bootable SD card from custom or pre-built binaries.

The script must be run with root permissions and from the bin directory of
the SDK

Example:
$ sudo ./mksdcard.sh
$ sudo ./mksdcard.sh recover

Formatting can be skipped if the SD card is already formatted and
partitioned properly.

################################################################################

EOM

AMIROOT=`whoami | awk {'print $1'}`
if [ "$AMIROOT" != "root" ] ; then

	echo "	**** Error *** must run script with sudo"
	echo ""
	exit
fi

# find the avaible SD cards
echo " "
echo "Availible Drives to write images to: "
echo " "
ROOTDRIVE=`mount | grep 'on / ' | awk {'print $1'} |  cut -c6-8`
echo "#  major   minor    size   name "
cat /proc/partitions | grep -v $ROOTDRIVE | grep '\<sd.\>' | grep -n ''
echo " "

ENTERCORRECTLY=0
while [ $ENTERCORRECTLY -ne 1 ]
do
	read -p 'Enter Device Number: ' DEVICEDRIVENUMBER
	echo " "
	DEVICEDRIVENAME=`cat /proc/partitions | grep -v 'sda' | grep '\<sd.\>' | grep -n '' | grep "${DEVICEDRIVENUMBER}:" | awk '{print $5}'`

	DRIVE=/dev/$DEVICEDRIVENAME
	DEVICESIZE=`cat /proc/partitions | grep -v 'sda' | grep '\<sd.\>' | grep -n '' | grep "${DEVICEDRIVENUMBER}:" | awk '{print $4}'`


	if [ -n "$DEVICEDRIVENAME" ]
	then
		ENTERCORRECTLY=1
	else
		echo "Invalid selection"
	fi

	echo ""
done

echo "$DEVICEDRIVENAME was selected"
#Check the size of disk to make sure its under 16GB
if [ $DEVICESIZE -gt 17000000 ] ; then
	cat << EOM

################################################################################

	**********WARNING**********

	Selected Device is greater then 16GB
	Continuing past this point will erase data from device
	Double check that this is the correct SD Card

################################################################################

EOM
	ENTERCORRECTLY=0
	while [ $ENTERCORRECTLY -ne 1 ]
	do
		read -p 'Would you like to continue [y/n] : ' SIZECHECK
		echo ""
		echo " "
		ENTERCORRECTLY=1
		case $SIZECHECK in
			"y")  ;;
			"n")  exit;;
			*)  echo "Please enter y or n";ENTERCORRECTLY=0;;
		esac
		echo ""
	done

fi

echo ""

device=/dev/$DEVICEDRIVENAME
test -z $sdkdir && sdkdir=pwd/image
test -z $device && usage $0

if [ ! -b $device ]; then
	echo "ERROR: $device is not a block device file"
	exit 1;
fi

echo "************************************************************"
echo "*         THIS WILL DELETE ALL THE DATA ON $device        *"
echo "*                                                          *"
echo "*         WARNING! Make sure your computer does not go     *"
echo "*                  in to idle mode while this script is    *"
echo "*                  running. The script will complete,      *"
echo "*                  but your SD card may be corrupted.      *"
echo "*                                                          *"
echo "*         Press <ENTER> to confirm....                     *"
echo "************************************************************"
read junk

for i in `ls -1 $device?`; do
	echo "unmounting device '$i'"
	umount $i 2>/dev/null
done

execute "sudo dd if=/dev/zero of=$device bs=1024 count=1024"

SIZE=`fdisk -l $device | grep Disk | awk '{print $5}'`
echo DISK SIZE - $SIZE bytes
if [ "$RECOVER" == 1 ];then
	sudo parted -s ${device} mklabel msdos
	sudo parted -s ${device} unit cyl mkpart primary fat32 -- 0 -2
	sudo parted -s ${device} set 1 boot on
	sleep 1
	execute "sudo mkfs.vfat -F 32 -n "sdcard" ${device}1"
else
	sudo parted -s ${device} mklabel msdos
	sudo parted -s ${device} unit cyl mkpart primary fat32 -- 0 9
	sudo parted -s ${device} set 1 boot on
	sudo parted -s ${device} unit cyl mkpart primary ext4 -- 9 -2
	sleep 1
	execute "sudo mkfs.vfat -F 32 -n "boot" ${device}1"
	execute "sudo mkfs.ext4 -L "rootfs" ${device}2"
fi

if [ "$RECOVER" == 0 ];then
	echo "copy images to fat32 partition"
	execute "mount ${device}1 /mnt"
	execute "cp ../images/logo.bmp /mnt"
	execute "cp ../images/zImage /mnt"
	execute "cp ../images/*.dtb /mnt"
	execute "cp ../images/MLO /mnt"
	execute "cp ../images/u-boot.img /mnt"
	execute "sync"
	execute "umount /mnt"
	echo "tar filesystem to ext4 partition"
	execute "rm -rf /mnt/rootfs"
	execute "mkdir /mnt/rootfs"
	execute "mount ${device}2 /mnt/rootfs"
	execute "tar -xvf /home/`cat user`/DJV2.0/rootfs.tar -C /mnt"
	execute "sync"
	execute "umount /mnt/rootfs"
	echo "completed!"
fi
