#!/bin/bash
cd ..
cp -rf /usr/share/djv2.0/sdk/OK5718-SDK-V1.0 ./
cd MSilicon_DVJ2.0
cp -rf ./src/*  ../OK5718-SDK-V1.0/
cp -rf ./patches/gpmc/OK57xx-linux-kernel/*  ../OK5718-SDK-V1.0/OK57xx-linux-kernel/
cp -rf ./patches/hid/OK57xx-linux-kernel/*  ../OK5718-SDK-V1.0/OK57xx-linux-kernel/


