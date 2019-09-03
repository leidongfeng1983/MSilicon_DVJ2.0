#! /bin/bash
         rm -rf /home/$USER/DJV2.0/tmp
	mkdir -p /home/$USER/DJV2.0/tmp/boot
	mkdir -p /home/$USER/DJV2.0/tmp/rootfs
	echo "copy images to fat32 partition"
	cp ../images/logo.bmp /home/$USER/DJV2.0/tmp/boot
	cp ../images/zImage /home/$USER/DJV2.0/tmp/boot
	cp ../images/*.dtb /home/$USER/DJV2.0/tmp/boot
	cp ../images/MLO /home/$USER/DJV2.0/tmp/boot
	cp ../images/u-boot.img /home/$USER/DJV2.0/tmp/boot
	echo "tar filesystem to ext4 partition"
	cp /home/`cat user`/DJV2.0/rootfs.tar /home/$USER/DJV2.0/tmp/rootfs
	tar -cvf /home/$USER/DJV2.0/canopen.img /home/$USER/DJV2.0/tmp
	echo "completed!"

