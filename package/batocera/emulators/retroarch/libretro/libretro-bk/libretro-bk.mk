################################################################################
#
# libretro-bk
#
################################################################################
# Version: Commits on Jul 26, 2022
LIBRETRO_BK_VERSION = cf70ce503ddb65051a58f3c4f61d1e258fc4c84b
LIBRETRO_BK_SITE = $(call github,libretro,bk-emulator,$(LIBRETRO_BK_VERSION))
LIBRETRO_BK_LICENSE = GPLv2

LIBRETRO_BK_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2835),y)
LIBRETRO_BK_PLATFORM = rpi1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2836),y)
LIBRETRO_BK_PLATFORM = rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2837),y)
LIBRETRO_BK_PLATFORM = rpi3_64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2711),y)
LIBRETRO_BK_PLATFORM = rpi4

else ifeq ($(BR2_aarch64),y)
LIBRETRO_BK_PLATFORM = unix

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S812),y)
LIBRETRO_BK_PLATFORM = armv

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RG35XX),y)
LIBRETRO_BK_PLATFORM = unix unix-armv7-hardfloat-neon
endif

define LIBRETRO_BK_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile.libretro platform="$(LIBRETRO_BK_PLATFORM)" \
        GIT_VERSION="-$(shell echo $(LIBRETRO_BK_VERSION) | cut -c 1-7)"
endef

define LIBRETRO_BK_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/bk_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/bk_libretro.so
endef

$(eval $(generic-package))
