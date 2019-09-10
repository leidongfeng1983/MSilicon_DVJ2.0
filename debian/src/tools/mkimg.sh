#! /bin/bash
        rm -rf tmp
	mkdir -p tmp/boot
	mkdir -p tmp/rootfs
	echo "copy images to fat32 partition"
	cp ../images/logo.bmp tmp/boot
	cp ../images/zImage tmp/boot
	cp ../images/*.dtb tmp/boot
	cp ../images/MLO tmp/boot
	cp ../images/u-boot.img tmp/boot
	if [ `cat os` == "emmc" ]; then
		cp ./ramdisk/update_ramdisk.img tmp/boot
	fi
	echo "tar filesystem to ext4 partition"
	if [ `cat os` == "debian" ]; then
		cp /usr/share/djv2.0/debian/rootfs.tar tmp/rootfs
	elif [ `cat os` == "emmc" ]; then
		cp /usr/share/djv2.0/debian/rootfs.tar tmp/rootfs
	elif [ `cat os` == "ubuntu" ]; then
		cp /usr/share/djv2.0/ubuntu/rootfs.tar tmp/rootfs
	elif [ `cat os` == "ethercat" ]; then
		cp /usr/share/djv2.0/ethercat/rootfs.tar tmp/rootfs
	elif [ `cat os` == "canopen" ]; then
		cp /usr/share/djv2.0/canopen/rootfs.tar tmp/rootfs
	fi
	tar -cvf /home/$USER/DJV2.0/`cat os`.img tmp
	rm -rf tmp
	echo "completed!"