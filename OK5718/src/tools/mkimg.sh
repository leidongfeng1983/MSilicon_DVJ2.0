#!/bin/bash 

DIR=$SDK_PATH_TARGET
rm /home/$USER/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-fs/etc/init.d/bluetooth
rm /home/$USER/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-fs/etc/init.d/hostapd
rm /home/$USER/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-fs/etc/init.d/hwclock.sh
rm /home/$USER/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-fs/etc/init.d/snmpd
rm /home/$USER/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-fs/etc/init.d/telnetd
rm /home/$USER/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-fs/etc/init.d/thermal-zone-init
cp -rf /home//$USER/DJV2.0/MSilicon_DVJ2.0/patches/eth/OK57xx-linux-fs/* /home/$USER/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-fs/
cp -rf /home//$USER/DJV2.0/MSilicon_DVJ2.0/patches/hdmi/OK57xx-linux-fs/* /home/$USER/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-fs/
cp -rf /home//$USER/DJV2.0/MSilicon_DVJ2.0/patches/gpmc/OK57xx-linux-fs/home/root/app-fram /home/$USER/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-fs/home/root/
cp -rf /home//$USER/DJV2.0/MSilicon_DVJ2.0/patches/gpmc/OK57xx-linux-fs/home/root/memread /home/$USER/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-fs/home/root/
cp -rf /home//$USER/DJV2.0/MSilicon_DVJ2.0/patches/gpmc/OK57xx-linux-fs/home/root/memwrite /home/$USER/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-fs/home/root/
fakeroot tar jcvf $SDK_PATH/images/OK57xx-linux-fs.tar.bz2  -C $DIR ./	\
	--exclude=./include			\
	--exclude=./usr/include			\
	--exclude=./usr/share/qt5/examples	\
	--exclude=./usr/lib/qt5/mkspecs		\
	\
	--exclude=./usr/share/ti/ti-sysbios-tree	\
	\
	--exclude=./usr/bin/chromium		\
	--exclude=./usr/bin/google-chrome	\
	--exclude=./usr/sbin/chrome-devel-sandbox	\
	--exclude=./usr/share/applications/google-chrome.desktop	\
	--exclude=./usr/lib/chromium		\
	\
	--exclude=./usr/bin/git				\
	--exclude=./usr/bin/git-receive-pack			\
	--exclude=./usr/bin/git-shell			\
	--exclude=./usr/bin/git-upload-archive		\
	--exclude=./usr/bin/git-upload-pack			\
	--exclude=./usr/libexec/git-core			\
	--exclude=./usr/share/git-core			\
	\
	--exclude=./usr/bin/arm-linux-gnueabihf*	\
	--exclude=./usr/libexec/gcc			\
	\
	--exclude=./lib/.debug				\
	\
 	--exclude=./etc/init.d/kdump				\
	--exclude=./etc/rc0.d/K56kdump			\
 	--exclude=./etc/rc1.d/K56kdump			\
 	--exclude=./etc/rc2.d/S56kdump			\
 	--exclude=./etc/rc3.d/S56kdump			\
 	--exclude=./etc/rc4.d/S56kdump			\
 	--exclude=./etc/rc5.d/S56kdump			\
 	--exclude=./etc/rc6.d/K56kdump			\
 	--exclude=./etc/sysconfig/kdump.conf			\
 	--exclude=./var/lib/opkg/info/kdump.control		\
 	--exclude=./var/lib/opkg/info/kdump.list		\
 	--exclude=./var/lib/opkg/info/kdump.postinst		\
 	--exclude=./var/lib/opkg/info/kdump.postrm		\
 	--exclude=./var/lib/opkg/info/kdump.preinst		\
 	--exclude=./var/lib/opkg/info/kdump.prerm		\
 	--exclude=./usr/sbin/kdump				\
	\
 	--exclude=./lib/firmware/ipc				\
 	--exclude=./usr/bin/ipc/examples			\
 	--exclude=./usr/share/ti/ti-ipc-tree/docs		\
	\
	--exclude=./usr/share/ti/examples/opencl/platforms			\
	--exclude=./usr/share/ti/examples/opencl/sgemm			\
	--exclude=./usr/share/ti/examples/opencl/simple			\
	--exclude=./usr/share/ti/examples/opencl/matmpy			\
	--exclude=./usr/share/ti/examples/opencl/null			\
	--exclude=./usr/share/ti/examples/opencl/offline_embed		\
	--exclude=./usr/share/ti/examples/opencl/persistent_clock_spanning	\
	--exclude=./usr/share/ti/examples/opencl/dgemm			\
	--exclude=./usr/share/ti/examples/opencl/monte_carlo			\
	--exclude=./usr/share/ti/examples/opencl/dsplib_fft			\
	--exclude=./usr/share/ti/examples/opencl/abort_exit			\
	--exclude=./usr/share/ti/examples/opencl/ccode			\
	--exclude=./usr/share/ti/examples/opencl/edmamgr			\
	--exclude=./usr/share/ti/examples/opencl/buffer			\
	--exclude=./usr/share/ti/examples/opencl/persistent_task_spanning	\
	--exclude=./usr/share/ti/examples/opencl/persistent_task_concurrent	\
	--exclude=./usr/share/ti/examples/opencl/timeout			\
	--exclude=./usr/share/ti/examples/opencl/offline			\
	--exclude=./usr/share/ti/examples/opencl/persistent_kernel_timeout	\
	--exclude=./usr/share/ti/examples/opencl/persistent_common		\
	--exclude=./usr/share/ti/examples/opencl/persistent_messageq_concurrent	\
	--exclude=./usr/share/ti/examples/opencl/persistent_clock_concurrent	\
	--exclude=./usr/share/ti/examples/opencl/ooo_callback		\
	\
	--exclude=./usr/share/ti/examples/linalg		\
	\
	--exclude=./usr/share/ti/video/HistoryOfTI-480p.264			\
	--exclude=./usr/share/ti/video/HistoryOfTI-480p.m2v			\
	--exclude=./usr/share/ti/video/HistoryOfTI-480p.m4v			\
	--exclude=./usr/share/ti/video/HistoryOfTIAV-WVGA.mp4		\
	--exclude=./usr/share/ti/video/HistoryOfTI-WVGA.264			\
	--exclude=./usr/share/ti/video/HistoryOfTI-WVGA.m2v			\
	--exclude=./usr/share/ti/video/HistoryOfTI-WVGA.m4v			\
	--exclude=./usr/share/ti/video/TearOfSteel-AV-Short-720x406.mp4	\
	--exclude=./usr/share/ti/video/TearOfSteel-AV-Short-720x420.mp4	\
	--exclude=./usr/share/ti/video/TearOfSteel-Short-720x406.264		\
	--exclude=./usr/share/ti/video/TearOfSteel-Short-720x406.m2v		\
	--exclude=./usr/share/ti/video/TearOfSteel-Short-720x406.m4v		\
	--exclude=./usr/share/ti/video/TearOfSteel-Short-720x420.264		\
	--exclude=./usr/share/ti/video/TearOfSteel-Short-720x420.m2v		\
	--exclude=./usr/share/ti/video/TearOfSteel-Short-720x420.m4v	
