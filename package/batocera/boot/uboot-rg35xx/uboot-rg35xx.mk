################################################################################
#
# uboot files for RG35XX
#
################################################################################

UBOOT_RG35XX_VERSION = 0a557e37a5274d40bcd357585d4bcd3b73619371
UBOOT_RG35XX_SITE = $(call github,rg35xx-cfw,u-boot_s500,$(UBOOT_RG35XX_VERSION))
UBOOT_RG35XX_LICENSE = GPLv2

UBOOT_RG35XX_DEPENDENCIES = host-toolchain-optional-linaro-arm

define UBOOT_RG35XX_BUILD_CMDS
    cd $(@D) && make ARCH=arm cubieboard6_s500_defconfig && make ARCH=arm CROSS_COMPILE=$(@D)/../../host/lib/gcc-linaro-arm-linux-gnueabi/bin/arm-linux-gnueabi- u-boot-dtb.img 
endef

define UBOOT_RG35XX_INSTALL_TARGET_CMDS
	cp $(@D)/u-boot-dtb.img $(BINARIES_DIR)/u-boot-rg35xx.img
endef

$(eval $(generic-package))
