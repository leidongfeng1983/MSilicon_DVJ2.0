#!/bin/bash
cd ..
tar -jxvf OK5718-SDK-V1.0.tar.bz2
cd MSilicon_DVJ2.0
rm -rf ../OK5718-SDK-V1.0/OK57xx-linux-kernel/*
cp -rf ../linux-4.9.41+gitAUTOINC+e3a80a1c5c-ge3a80a1c5c/*  ../OK5718-SDK-V1.0/OK57xx-linux-kernel/
cp -rf ./src/*  ../OK5718-SDK-V1.0/
cp -rf ./patches/gpmc/OK57xx-linux-kernel/*  ../OK5718-SDK-V1.0/OK57xx-linux-kernel/
cp -rf ./patches/hid/OK57xx-linux-kernel/*  ../OK5718-SDK-V1.0/OK57xx-linux-kernel/

cd ..
cd OK5718-SDK-V1.0

