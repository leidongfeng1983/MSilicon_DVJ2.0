#!/bin/bash
cd ..
cp -rf /usr/share/djv2.0/sdk/OK5718-SDK-V1.0 ./
cd MSilicon_DVJ2.0
rm -rf ../OK5718-SDK-V1.0/OK57xx-linux-kernel/*
cp -rf /usr/share/djv2.0/sdk/linux-4.14.79/*  ../OK5718-SDK-V1.0/OK57xx-linux-kernel/
cp -rf ./src/*  ../OK5718-SDK-V1.0/
cp os  ../OK5718-SDK-V1.0/tools/

