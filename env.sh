#!/bin/bash
cp /usr/share/djv2.0/sdk/OK5718-SDK-V1.0.tar.bz2 ./
cp /usr/share/djv2.0sdk/linux-4.9.41.tar ./
cp /usr/share/djv2.0/sdk/linux-4.14.79.tar ./
tar -xvf linux-4.9.41.tar
tar -xvf linux-4.14.79.tar
mv OK5718-SDK-V1.0.tar.bz2 ../
mv linux-4.14.79+gitAUTOINC+e669d52447-ge669d52447 ../
mv linux-4.9.41+gitAUTOINC+e3a80a1c5c-ge3a80a1c5c ../
rm linux-4.9.41.tar
rm linux-4.14.79.tar



