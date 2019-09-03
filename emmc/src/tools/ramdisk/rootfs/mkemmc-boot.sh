#! /bin/sh
# Script to create SD card for 572x plaform.
#
# Author: Brijesh Singh, Texas Instruments Inc.
#
# Licensed under terms of GPLv2

VERSION="0.4"

function dots(){
seconds=${1:-5}
while true
do
	ps -a | grep cp | grep mmcblk1p2 > /dev/null 
	if [ $? -eq 0 ]; then
		sleep $seconds
		echo -n -e "\b=>" > /dev/tty0
	else
		break
	fi
done
}

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

lcdout()
{
	$* >/dev/tty0
	echo " " > /dev/tty0
}

if [ -d /sys/class/tty/tty0 ];then
	MAJOR=`cat /sys/class/tty/tty0/uevent | grep MAJOR | awk -F '=' '{print $2}'`
	MINOR=`cat /sys/class/tty/tty0/uevent | grep MINOR | awk -F '=' '{print $2}'`
	mknod /dev/tty0 c $MAJOR $MINOR
fi

mknod /dev/zero c 1 5

if [ -d /sys/class/block/mmcblk1 ];then
	MAJOR=`cat /sys/class/block/mmcblk1/uevent | grep MAJOR | awk -F '=' '{print $2}'`
	MINOR=`cat /sys/class/block/mmcblk1/uevent | grep MINOR | awk -F '=' '{print $2}'`
	mknod /dev/mmcblk1 b $MAJOR $MINOR
fi

#/mknod.sh

cat << EOF >> /dev/tty0

#######################################################

Forlinx AM57xx SD Update...

This script divides the emmc into two partitions.

1: fat32
2: ext4

Then copy all files from sdcard to emmc.

www.forlinx.com

########################################################

EOF

start=`date +%s`

device=/dev/mmcblk1

execute "dd if=/dev/zero of=$device bs=1024 count=1024"

SIZE=`fdisk -l $device | grep Disk | awk '{print $5}'`
echo DISK SIZE - $SIZE bytes

parted -s ${device} mklabel msdos
parted -s ${device} unit cyl mkpart primary fat32 -- 0 9
parted -s ${device} set 1 boot on
parted -s ${device} unit cyl mkpart primary ext2 -- 9 -2

sleep 1

if [ -d /sys/class/block/mmcblk0/mmcblk0p1 ];then
	MAJOR=`cat /sys/class/block/mmcblk0/mmcblk0p1/uevent | grep MAJOR | awk -F '=' '{print $2}'`
	MINOR=`cat /sys/class/block/mmcblk0/mmcblk0p1/uevent | grep MINOR | awk -F '=' '{print $2}'`
	mknod /dev/mmcblk0p1 b $MAJOR $MINOR
fi

if [ -d /sys/class/block/mmcblk0/mmcblk0p2 ];then
	MAJOR=`cat /sys/class/block/mmcblk0/mmcblk0p2/uevent | grep MAJOR | awk -F '=' '{print $2}'`
	MINOR=`cat /sys/class/block/mmcblk0/mmcblk0p2/uevent | grep MINOR | awk -F '=' '{print $2}'`
	mknod /dev/mmcblk0p2 b $MAJOR $MINOR
fi

if [ -d /sys/class/block/mmcblk1/mmcblk1p1 ];then
	MAJOR=`cat /sys/class/block/mmcblk1/mmcblk1p1/uevent | grep MAJOR | awk -F '=' '{print $2}'`
	MINOR=`cat /sys/class/block/mmcblk1/mmcblk1p1/uevent | grep MINOR | awk -F '=' '{print $2}'`
	mknod /dev/mmcblk1p1 b $MAJOR $MINOR
fi

if [ -d /sys/class/block/mmcblk1/mmcblk1p2 ];then
	MAJOR=`cat /sys/class/block/mmcblk1/mmcblk1p2/uevent | grep MAJOR | awk -F '=' '{print $2}'`
	MINOR=`cat /sys/class/block/mmcblk1/mmcblk1p2/uevent | grep MINOR | awk -F '=' '{print $2}'`
	mknod /dev/mmcblk1p2 b $MAJOR $MINOR
fi

lcdout "echo "Formating ${device}p1 ...""
mkfs.vfat -F 32 -n "boot" ${device}p1
lcdout "echo "Formating ${device}p2 ...""
mkfs.ext4 -L "rootfs" ${device}p2 << EOF
y
EOF


mkdir /tmp/boot_sd
mkdir /tmp/boot
mkdir /tmp/rootfs_sd
mkdir /tmp/rootfs


sleep 1

execute "mount -t vfat /dev/mmcblk0p1 /tmp/boot_sd"
execute "mount -t ext4 /dev/mmcblk0p2 /tmp/rootfs_sd"
execute "mount -t vfat /dev/mmcblk1p1 /tmp/boot"
execute "mount -t ext4 /dev/mmcblk1p2 /tmp/rootfs"


lcdout "echo "Copying mmcblk0p1/* to ${device}p1""
cp -rf /tmp/boot_sd/* /tmp/boot/
lcdout "echo "Copy mmcblk0p1/* to ${device}p1 Finished!""
sync

lcdout "echo "Copying filesystem on ${device}p2 ...""
execute "tar -xvf /tmp/rootfs_sd/rootfs.tar -C /tmp"
lcdout "echo " ""
lcdout "echo "Copy filesystem on ${device}p2 Finished!""
lcdout "echo "syncing...""
sync
sync

end=`date +%s`
use=`expr $end - $start`

execute "umount /tmp/boot_sd"
execute "umount /tmp/rootfs_sd"
execute "umount /tmp/boot"
execute "umount /tmp/rootfs"

lcdout "echo "completed! use $use s""

