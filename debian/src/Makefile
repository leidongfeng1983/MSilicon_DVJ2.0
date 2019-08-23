MAKE_JOBS ?= 32
all: linux linux-dtbs   
install: linux_install linux-dtbs_install  
clean: linux_clean linux-dtbs_clean   

# Kernel build targets
linux:  export CPATH=
linux:  
	@cp -f /home/$(USER)/DJV2.0/MSilicon_DVJ2.0/src/OK57xx-linux-kernel/arch/arm/boot/dts/ok5718-idk-touch_gt911.dts /home/$(USER)/DJV2.0/OK5718-SDK-V1.0/OK57xx-linux-kernel/arch/arm/boot/dts/
	@echo =================================
	@echo     Building the Linux Kernel
	@echo =================================
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(DEFCONFIG)
	$(MAKE) -j $(MAKE_JOBS) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) zImage
	$(MAKE) -j $(MAKE_JOBS) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) modules

linux_install: 
	@echo ===================================
	@echo     Installing the Linux Kernel
	@echo ===================================
	@if [ ! -d $(DESTDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	install $(LINUXKERNEL_INSTALL_DIR)/arch/arm/boot/zImage ./images
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) INSTALL_MOD_PATH=$(DESTDIR) INSTALL_MOD_STRIP=$(INSTALL_MOD_STRIP) modules_install

linux_clean:
	@echo =================================
	@echo     Cleaning the Linux Kernel
	@echo =================================
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) mrproper

# Kernel DTB build targets
linux-dtbs: export CPATH=
linux-dtbs:
	@echo =====================================
	@echo     Building the Linux Kernel DTBs
	@echo =====================================
	$(MAKE) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(DEFCONFIG)
	$(MAKE) -j $(MAKE_JOBS) -C $(LINUXKERNEL_INSTALL_DIR) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) $(KERNEL_DEVICETRE1)

linux-dtbs_install:
	@echo =======================================
	@echo     Installing the Linux Kernel DTBs
	@echo =======================================
	@if [ ! -d $(DESTDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	@cp -f $(LINUXKERNEL_INSTALL_DIR)/arch/arm/boot/dts/*.dtb ./images

linux-dtbs_clean:
	@echo =======================================
	@echo     Cleaning the Linux Kernel DTBs
	@echo =======================================
	@echo "Nothing to do"


# EXTRA DRIVERS
extra_drivers: linux cmem-mod cryptodev gdbserverproxy-module-drv uio-module-drv debugss-module-drv ti-sgx-ddk-km
extra_drivers_clean: cmem-mod_clean cryptodev_clean gdbserverproxy-module-drv_clean uio-module-drv_clean debugss-module-drv_clean ti-sgx-ddk-km_clean
extra_drivers_install: linux_install cmem-mod_install cryptodev_install gdbserverproxy-module-drv_install uio-module-drv_install debugss-module-drv_install ti-sgx-ddk-km_install
# CMEM module
cmem-mod:
	@echo ================================
	@echo     Building CMEM Module
	@echo ================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "cmem-mod*"`; \
	make -f lu.mak ARCH=arm KERNEL_INSTALL_DIR=$(LINUXKERNEL_INSTALL_DIR) module

cmem-mod_clean:
	@echo ================================
	@echo     Cleaning CMEM Module
	@echo ================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "cmem-mod*"`; \
	make -f lu.mak ARCH=arm KERNEL_INSTALL_DIR=$(LINUXKERNEL_INSTALL_DIR) modules_clean

cmem-mod_install:
	@echo ================================
	@echo     Installing CMEM Module
	@echo ================================
	@if [ ! -d $(DESTDIR) ] ; then \
	echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "cmem-mod*"`; \
	make -C $(LINUXKERNEL_INSTALL_DIR) SUBDIRS=`pwd`/src/cmem/module INSTALL_MOD_PATH=$(DESTDIR) PREFIX=$(SDK_PATH_TARGET) INSTALL_MOD_STRIP=$(INSTALL_MOD_STRIP) modules_install

cryptodev: 
	@echo ================================
	@echo      Building cryptodev-linux
	@echo ================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "cryptodev*"`; \
	make ARCH=arm KERNEL_DIR=$(LINUXKERNEL_INSTALL_DIR)

cryptodev_clean:
	@echo ================================
	@echo      Cleaning cryptodev-linux
	@echo ================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "cryptodev*"`; \
	make ARCH=arm KERNEL_DIR=$(LINUXKERNEL_INSTALL_DIR) clean

cryptodev_install:
	@echo ================================
	@echo      Installing cryptodev-linux
	@echo ================================
	@if [ ! -d $(DESTDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "cryptodev*"`; \
	make ARCH=arm  KERNEL_DIR=$(LINUXKERNEL_INSTALL_DIR)  INSTALL_MOD_PATH=$(DESTDIR) PREFIX=$(SDK_PATH_TARGET) INSTALL_MOD_STRIP=$(INSTALL_MOD_STRIP) install

gdbserverproxy-module-drv:
	@echo ==============================================
	@echo      Building gdbserverproxy-module-drv
	@echo ==============================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "gdbserverproxy*"`; \
	make ARCH=arm KERNEL_SRC=$(LINUXKERNEL_INSTALL_DIR) PLATFORM=DRA7xx_PLATFORM

gdbserverproxy-module-drv_clean:
	@echo ==============================================
	@echo      Cleaning gdbserverproxy-module-drv
	@echo ==============================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "gdbserverproxy*"`; \
	make ARCH=arm KERNEL_SRC=$(LINUXKERNEL_INSTALL_DIR) PLATFORM=DRA7xx_PLATFORM clean

gdbserverproxy-module-drv_install:
	@echo ==============================================
	@echo      Installing gdbserverproxy-module-drv
	@echo ==============================================
	@if [ ! -d $(DESTDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "gdbserverproxy*"`; \
	make ARCH=arm  KERNEL_SRC=$(LINUXKERNEL_INSTALL_DIR)  INSTALL_MOD_PATH=$(DESTDIR) PREFIX=$(SDK_PATH_TARGET) INSTALL_MOD_STRIP=$(INSTALL_MOD_STRIP) PLATFORM=DRA7xx_PLATFORM modules_install

uio-module-drv:
	@echo ================================
	@echo      Building uio-module-drv
	@echo ================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "uio-module-drv*"`; \
	make ARCH=arm KERNEL_SRC=$(LINUXKERNEL_INSTALL_DIR)

uio-module-drv_clean:
	@echo ================================
	@echo      Cleaning uio-module-drv
	@echo ================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "uio-module-drv*"`; \
	make ARCH=arm KERNEL_SRC=$(LINUXKERNEL_INSTALL_DIR) clean

uio-module-drv_install:
	@echo ================================
	@echo      Installing uio-module-drv
	@echo ================================
	@if [ ! -d $(DESTDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "uio-module-drv*"`; \
	make ARCH=arm  KERNEL_SRC=$(LINUXKERNEL_INSTALL_DIR)  INSTALL_MOD_PATH=$(DESTDIR) PREFIX=$(SDK_PATH_TARGET) INSTALL_MOD_STRIP=$(INSTALL_MOD_STRIP) modules_install

debugss-module-drv:
	@echo =======================================
	@echo      Building debugss-module-drv
	@echo =======================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "debugss*"`; \
	make ARCH=arm KERNEL_SRC=$(LINUXKERNEL_INSTALL_DIR) PLATFORM=DRA7xx_PLATFORM

debugss-module-drv_clean:
	@echo =======================================
	@echo      Cleaning debugss-module-drv
	@echo =======================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "debugss*"`; \
	make ARCH=arm KERNEL_SRC=$(LINUXKERNEL_INSTALL_DIR) PLATFORM=DRA7xx_PLATFORM clean

debugss-module-drv_install:
	@echo =======================================
	@echo      Installing debugss-module-drv
	@echo =======================================
	@if [ ! -d $(DESTDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "debugss*"`; \
	make ARCH=arm  KERNEL_SRC=$(LINUXKERNEL_INSTALL_DIR)  INSTALL_MOD_PATH=$(DESTDIR) PREFIX=$(SDK_PATH_TARGET) INSTALL_MOD_STRIP=$(INSTALL_MOD_STRIP) PLATFORM=DRA7xx_PLATFORM modules_install

# ti-sgx-ddk-km module
ti-sgx-ddk-km:
	@echo ================================
	@echo      Building ti-sgx-ddk-km
	@echo ================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "ti-sgx-ddk-km*" -type d`; \
	make -C ./eurasia_km/eurasiacon/build/linux2/omap_linux ARCH=arm TARGET_PRODUCT=jacinto6evm KERNELDIR=$(LINUXKERNEL_INSTALL_DIR)

ti-sgx-ddk-km_clean:
	@echo ================================
	@echo      Cleaning ti-sgx-ddk-km
	@echo ================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "ti-sgx-ddk-km*" -type d`; \
	make -C ./eurasia_km/eurasiacon/build/linux2/omap_linux ARCH=arm KERNELDIR=$(LINUXKERNEL_INSTALL_DIR) clean

ti-sgx-ddk-km_install:
	@echo ================================
	@echo      Installing ti-sgx-ddk-km
	@echo ================================
	@cd extra-drivers; \
	cd `find . -maxdepth 1 -name "ti-sgx-ddk-km*" -type d`; \
	cd ./eurasia_km/eurasiacon/binary2_omap_linux_release/target/kbuild; \
	make -C $(LINUXKERNEL_INSTALL_DIR) SUBDIRS=`pwd` INSTALL_MOD_PATH=$(DESTDIR) PREFIX=$(SDK_PATH_TARGET) INSTALL_MOD_STRIP=$(INSTALL_MOD_STRIP) modules_install

# qt examples
qt-examples:
	@echo =====================================
	@echo     Building the Qt Examples
	@echo =====================================
	@cd `find . -name "appsrc"`; cd `find . -name "qt"`; qmake; make -j $(MAKE_JOBS)

qt-examples_install:
	@echo =======================================
	@echo     Installing the Qt Examples
	@echo =======================================
	@if [ ! -d $(DESTDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	cd `find . -name "appsrc"`; cd `find . -name "qt"`; make install 

qt-examples_clean:
	@echo =======================================
	@echo     Cleaning the Qt Examples
	@echo =======================================
	@cd `find . -name "appsrc"`; cd `find . -name "qt"`; make distclean

CMDBINDIR=$(DESTDIR)/home/forlinx/cmd
# OpenCV
opencv-examples:
	@echo =====================================
	@echo     Building the Opencv Examples
	@echo =====================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "opencv"`; make 

opencv-examples_install:
	@echo =======================================
	@echo     Installing the Opencv Examples
	@echo =======================================
	@if [ ! -d $(CMDBINDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "opencv"`; \
	for example in `find . -executable -not \( -type d -o -iname 'make*' \)`; do \
		install -m 755 $${example} $(CMDBINDIR)/$${example} ; \
	done

opencv-examples_clean:
	@echo =======================================
	@echo     Cleaning the Opencv Examples
	@echo =======================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "opencv"`; make clean

# CMD 
cmd-examples: shooter-examples keytest-examples watchdog-examples watchdogrestart-examples uarttest-examples spitest-examples vpe-examples
cmd-examples_install: shooter-examples_install keytest-examples_install watchdog-examples_install watchdogrestart-examples_install uarttest-examples_install spitest-examples_install vpe-examples_install
cmd-examples_clean: shooter-examples_clean keytest-examples_clean watchdog-examples_clean watchdogrestart-examples_clean uarttest-examples_clean spitest-examples_clean vpe-examples_clean

# VPE
vpe-examples:
	@echo =====================================
	@echo     Building the VPE Examples
	@echo =====================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "vpe"`; make 

vpe-examples_install:
	@echo =======================================
	@echo     Installing the VPE Examples
	@echo =======================================
	@if [ ! -d $(CMDBINDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "vpe"`; \
	for example in `find . -executable -not \( -type d -o -iname 'make*' \)`; do \
		install -m 755 $${example} $(CMDBINDIR)/$${example} ; \
	done

vpe-examples_clean:
	@echo =======================================
	@echo     Cleaning the Shooter Examples
	@echo =======================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "vpe"`; make clean

# Screen shooter
shooter-examples:
	@echo =====================================
	@echo     Building the Shooter Examples
	@echo =====================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "screenshooter"`; make 

shooter-examples_install:
	@echo =======================================
	@echo     Installing the Shooter Examples
	@echo =======================================
	@if [ ! -d $(CMDBINDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "screenshooter"`; \
	for example in `find . -executable -not \( -type d -o -iname 'make*' \)`; do \
		install -m 755 $${example} $(CMDBINDIR)/$${example} ; \
	done

shooter-examples_clean:
	@echo =======================================
	@echo     Cleaning the Shooter Examples
	@echo =======================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "screenshooter"`; make clean

# keytest
keytest-examples:
	@echo =====================================
	@echo     Building the keytest Examples
	@echo =====================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "keytest"`; make 

keytest-examples_install:
	@echo =======================================
	@echo     Installing the keytest Examples
	@echo =======================================
	@if [ ! -d $(CMDBINDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "keytest"`; \
	for example in `find . -executable -not \( -type d -o -iname 'make*' \)`; do \
		install -m 755 $${example} $(CMDBINDIR)/$${example} ; \
	done

keytest-examples_clean:
	@echo =======================================
	@echo     Cleaning the keytest Examples
	@echo =======================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "keytest"`; make clean

# watchdog
watchdog-examples:
	@echo =====================================
	@echo     Building the keytest Examples
	@echo =====================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "watchdog"`; make 

watchdog-examples_install:
	@echo =======================================
	@echo     Installing the watchdog Examples
	@echo =======================================
	@if [ ! -d $(CMDBINDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "watchdog"`; \
	for example in `find . -executable -not \( -type d -o -iname 'make*' \)`; do \
		install -m 755 $${example} $(CMDBINDIR)/$${example} ; \
	done

watchdog-examples_clean:
	@echo =======================================
	@echo     Cleaning the watchdog Examples
	@echo =======================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "watchdog"`; make clean

# watchdogrestart
watchdogrestart-examples:
	@echo =====================================
	@echo     Building the watchdogrestart Examples
	@echo =====================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "watchdogrestart"`; make 

watchdogrestart-examples_install:
	@echo =======================================
	@echo     Installing the Shooter Examples
	@echo =======================================
	@if [ ! -d $(CMDBINDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "watchdogrestart"`; \
	for example in `find . -executable -not \( -type d -o -iname 'make*' \)`; do \
		install -m 755 $${example} $(CMDBINDIR)/$${example} ; \
	done

watchdogrestart-examples_clean:
	@echo =======================================
	@echo     Cleaning the Shooter Examples
	@echo =======================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "watchdogrestart"`; make clean

# uarttest
uarttest-examples:
	@echo =====================================
	@echo     Building the uarttest Examples
	@echo =====================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "uarttest"`; make 

uarttest-examples_install:
	@echo =======================================
	@echo     Installing the uarttest Examples
	@echo =======================================
	@if [ ! -d $(CMDBINDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "uarttest"`; \
	for example in `find . -executable -not \( -type d -o -iname 'make*' \)`; do \
		install -m 755 $${example} $(CMDBINDIR)/$${example} ; \
	done

uarttest-examples_clean:
	@echo =======================================
	@echo     Cleaning the uarttest Examples
	@echo =======================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "uarttest"`; make clean

# spitest
spitest-examples:
	@echo =====================================
	@echo     Building the spitest Examples
	@echo =====================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "spitest"`; make 

spitest-examples_install:
	@echo =======================================
	@echo     Installing the spitest Examples
	@echo =======================================
	@if [ ! -d $(CMDBINDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "spitest"`; \
	for example in `find . -executable -not \( -type d -o -iname 'make*' \)`; do \
		install -m 755 $${example} $(CMDBINDIR)/$${example} ; \
	done

spitest-examples_clean:
	@echo =======================================
	@echo     Cleaning the spitest Examples
	@echo =======================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "spitest"`; make clean

# OpenCL Examples build targets
opencl-examples:
	@echo =====================================
	@echo     Building the OpenCL Examples
	@echo =====================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "*opencl-examples*"`; make TARGET_ROOTDIR=$(SDK_PATH_TARGET) TI_OCL_CGT_INSTALL=$(SDK_PATH_TARGET)/usr/share/ti/cgt-c6x EXAMPLE_SET=EXCLUDE_PERSISTENT

opencl-examples_install:
	@echo =======================================
	@echo     Installing the OpenCL Examples
	@echo =======================================
	@if [ ! -d $(DESTDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "*opencl-examples*"`; \
	for example in `find . -executable -not \( -type d -o -iname 'make*' \)`; do \
		install -d $(DESTDIR)/usr/share/ti/examples/opencl/`dirname $${example}` ; \
		install -m 755 $${example} $(DESTDIR)/usr/share/ti/examples/opencl/`dirname $${example}` ; \
		if [ -f `dirname $${example}`/*.out ]; then \
			install -m 755 `dirname $${example}`/*.out $(DESTDIR)/usr/share/ti/examples/opencl/`dirname $${example}` ; \
		fi \
	done

opencl-examples_clean:
	@echo =======================================
	@echo     Cleaning the OpenCL Examples
	@echo =======================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "*opencl-examples*"`; make TARGET_ROOTDIR=$(SDK_PATH_TARGET) clean

# OpenMP Accelerator Examples build targets
openmpacc-examples:
	@echo ================================================
	@echo     Building the OpenMP Accelerator Examples
	@echo ================================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "*openmpacc-examples*"`; make TARGET_ROOTDIR=$(SDK_PATH_TARGET) TI_OCL_CGT_INSTALL=$(SDK_PATH_TARGET)/usr/share/ti/cgt-c6x

openmpacc-examples_install:
	@echo ==================================================
	@echo     Installing the OpenMP Accelerator Examples
	@echo ==================================================
	@if [ ! -d $(DESTDIR) ] ; then \
		echo "The extracted target filesystem directory doesn't exist."; \
		echo "Please run setup.sh in the SDK's root directory and then try again."; \
		exit 1; \
	fi
	cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "*openmpacc-examples*"`; \
	for example in `find . -executable -not \( -type d -o -iname 'make*' \)`; do \
		install -d $(DESTDIR)/usr/share/ti/examples/openmpacc/`dirname $${example}` ; \
		install -m 755 $${example} $(DESTDIR)/usr/share/ti/examples/openmpacc/`dirname $${example}` ; \
		if [ -f `dirname $${example}`/*.out ]; then \
			install -m 755 `dirname $${example}`/*.out $(DESTDIR)/usr/share/ti/examples/openmpacc/`dirname $${example}` ; \
		fi \
	done

openmpacc-examples_clean:
	@echo ==================================================
	@echo     Cleaning the OpenMP Accelerator Examples
	@echo ==================================================
	@cd `find . -name "appsrc"`; cd `find . -name "cmd"`; cd `find . -name "*openmpacc-examples*"`; make TARGET_ROOTDIR=$(SDK_PATH_TARGET) clean

