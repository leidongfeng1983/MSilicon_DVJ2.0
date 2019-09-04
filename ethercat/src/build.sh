#!/bin/bash
make
make install
cd .tools
./mkimg.sh
cd ..

