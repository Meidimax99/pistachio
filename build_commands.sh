#!/bin/sh

# to be run from the repo-root

cd kernel
make BUILDDIR=$(pwd)/../x86-kernel-build

cd ../x86-kernel-build
make menuconfig
make