#!/bin/bash

# HOST_DIR = host dir
# BOARD_DIR = board specific dir
# BUILD_DIR = base dir/build
# BINARIES_DIR = images dir
# TARGET_DIR = target dir
# BATOCERA_BINARIES_DIR = batocera binaries sub directory

HOST_DIR=$1
BOARD_DIR=$2
BUILD_DIR=$3
BINARIES_DIR=$4
TARGET_DIR=$5
BATOCERA_BINARIES_DIR=$6

mkdir -p "${BATOCERA_BINARIES_DIR}/boot/boot"     || exit 1

cp "${BINARIES_DIR}/uImage"             "${BATOCERA_BINARIES_DIR}/boot/uImage"               || exit 1
cp "${BINARIES_DIR}/uInitrd"            "${BATOCERA_BINARIES_DIR}/boot/ramdisk.img"          || exit 1
cp "${BINARIES_DIR}/rg35xx_atm7039.dtb" "${BATOCERA_BINARIES_DIR}/boot/kernel.dtb"           || exit 1
cp "${BINARIES_DIR}/2600mAh-gpu.dtb"    "${BATOCERA_BINARIES_DIR}/boot/2600mAh-gpu.dtb"      || exit 1
cp "${BINARIES_DIR}/2100mAh-gpu.dtb"    "${BATOCERA_BINARIES_DIR}/boot/2100mAh-gpu.dtb"      || exit 1
#cp "${BINARIES_DIR}/rootfs.squashfs"    "${BATOCERA_BINARIES_DIR}/boot/boot/batocera.update" || exit 1
cp "${BINARIES_DIR}/rootfs.ext2"        "${BATOCERA_BINARIES_DIR}/boot/boot/batocera.update" || exit 1
cp "${BINARIES_DIR}/adb_uImage"         "${BATOCERA_BINARIES_DIR}/boot/adb_uImage"           || exit 1
cp "${BINARIES_DIR}/batocera-boot.conf" "${BATOCERA_BINARIES_DIR}/boot/batocera-boot.conf"   || exit 1

cp "${BOARD_DIR}/boot_logo.bmp.gz"      "${BATOCERA_BINARIES_DIR}/boot/boot_logo.bmp.gz"     || exit 1
cp "${BOARD_DIR}/uEnv.txt"              "${BATOCERA_BINARIES_DIR}/boot/uEnv.txt"             || exit 1

touch "${BATOCERA_BINARIES_DIR}/boot/boot/firstBoot"

exit 0
