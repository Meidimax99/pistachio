#!/bin/sh

# to be run from the repo-root

cd kernel
make BUILDDIR=$(pwd)/../build-kernel-x86

cd ../build-kernel-x86
make menuconfig
make