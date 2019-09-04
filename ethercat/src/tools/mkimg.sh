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
	echo "tar filesystem to ext4 partition"
        wget 127.0.0.1/dist/ethercat/rootfs.tar 
	mv rootfs.tar tmp/rootfs
	tar -cvf /home/$USER/DJV2.0/ethercat.img tmp
	rm -rf tmp
	echo "completed!"

