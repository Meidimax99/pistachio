#!/bin/zsh

# TODO Central location for Build/Install directory variables

# TODO Configuration creates config.mk that is not able to generate the user files
# CXXFLAGS=		-fno-builtin -nostdinc
# Required in build-user-x86/apps/l4test/Makefile

DIRECTORY=./build-user-x86
if [ ! -d "$DIRECTORY" ]; then
    mkdir $DIRECTORY
fi
cd $DIRECTORY
../user/configure --with-comport=0 --with-comspeed=115200 --prefix=`pwd`/../install-user-x86 --with-kerneldir=`pwd`/../build-kernel-x86
make
make install