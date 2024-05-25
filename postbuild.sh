#!/bin/zsh

# This script should be called after the build of both the user and the kernel have succeeded
# It will combine the user and the kernel code in a fdsource directory, which will then form the basis for the disc image to be created and booted in qemu

# Execute this from the repositories root directory

BUILD_DIR_KERNEL="build-kernel-x86"
BUILD_DIR_USER="build-user-x86"
INSTALL_DIR_USER="install-user-x86"

if [ ! -d "fdsource" ]; then
  mkdir fdsource
fi

cp ./$BUILD_DIR_KERNEL/x86-kernel ./fdsource/
cp -r ./$INSTALL_DIR_USER/libexec/l4/* ./fdsource/
