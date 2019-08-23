#!/bin/bash
XENO_VER=3.0.8
IPIPE_VER=4.9.38-x86-4
KERNEL_VER=4.9.38
PATH_VER=/home/$USER/DJV2.0/xenomai-x86

#other version
#IPIPE_VER=4.4.43-x86-8
#KERNEL_VER=4.4.43

cat << EOM

###################################################################################

This script will clean the compile environment.

This scrip must run root or you can sudo 

Example:
$ ./clean.sh
$ ./clean.sh all

###################################################################################

EOM

if [ "$#" == 1 -a "$1" == "all" ]; then
	rm -rf $PATH_VER
else 
	rm -rf $PATH_VER/xenomai-$XENO_VER $PATH_VER/linux-$KERNEL_VER
fi


