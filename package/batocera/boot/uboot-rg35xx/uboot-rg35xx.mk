################################################################################
#
# uboot files for sunxi r16
#
################################################################################

UBOOT_SUNXI_RG35XX_VERSION = 0a557e3
UBOOT_SUNXI_RG35XX_SITE = $(call github,aron0330,u-boot_s500,$(UBOOT_SUNXI_RG35XX_VERSION))
UBOOT_SUNXI_RG35XX_LICENSE = GPLv2

UBOOT_SUNXI_RG35XX_DEPENDENCIES = host-toolchain-optional-linaro-arm

define UBOOT_SUNXI_RG35XX_BUILD_CMDS
    cd $(@D) && chmod +x add_hash.sh && sh build.sh
endef

define UBOOT_SUNXI_RG35XX_INSTALL_TARGET_CMDS
	cp $(@D)/u-boot-dtb.img $(BINARIES_DIR)/u-boot-rg35xx.img
endef

$(eval $(generic-package))
