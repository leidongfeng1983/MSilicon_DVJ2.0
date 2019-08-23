#!/bin/bash
cd ..
tar -jxvf OK5718-SDK-V1.0.tar.bz2
cd MSilicon_DVJ2.0
rm -rf ../OK5718-SDK-V1.0/OK57xx-linux-kernel/*
cp -rf /home/$USER/ti-processor-sdk-linux-am57xx-evm-05.03.00.07/board-support/linux-4.14.79+gitAUTOINC+e669d52447-ge669d52447/*  ../OK5718-SDK-V1.0/OK57xx-linux-kernel/
cp -rf ./src/*  ../OK5718-SDK-V1.0/
cd ..
cd OK5718-SDK-V1.0

