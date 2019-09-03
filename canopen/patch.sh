#!/bin/bash
cd ..
rm rootfs.tar
wget http://127.0.0.1/dist/canopen/rootfs.tar
tar -jxvf OK5718-SDK-V1.0.tar.bz2
cd MSilicon_DVJ2.0
rm -rf ../OK5718-SDK-V1.0/OK57xx-linux-kernel/*
cp -rf ../linux-4.14.79+gitAUTOINC+e669d52447-ge669d52447/*  ../OK5718-SDK-V1.0/OK57xx-linux-kernel/
cp -rf ./src/*  ../OK5718-SDK-V1.0/
cd ..
cd OK5718-SDK-V1.0

