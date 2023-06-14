################################################################################
#
# toolchain-optional-linaro-arm
#
################################################################################

TOOLCHAIN_OPTIONAL_LINARO_ARM_VERSION = 4.9.4-2017.01
TOOLCHAIN_OPTIONAL_LINARO_ARM_SITE = https://releases.linaro.org/components/toolchain/binaries/4.9-2017.01/arm-linux-gnueabi

ifeq ($(HOSTARCH),x86)
	TOOLCHAIN_OPTIONAL_LINARO_ARM_SOURCE = gcc-linaro-4.9.4-2017.01-I686_arm-linux-gnueabi.tar.xz
else
	TOOLCHAIN_OPTIONAL_LINARO_ARM_SOURCE = gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabi.tar.xz
endif

# wrap gcc and g++ with ccache like in gcc package.mk
PKG_GCC_PREFIX="$(HOST_DIR)/lib/gcc-linaro-arm-linux-gnueabi/bin/arm-linux-gnueabi-"

define HOST_TOOLCHAIN_OPTIONAL_LINARO_ARM_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/lib/gcc-linaro-arm-linux-gnueabi/
	cp -a $(@D)/* $(HOST_DIR)/lib/gcc-linaro-arm-linux-gnueabi
endef

$(eval $(host-generic-package))
