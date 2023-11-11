################################################################################
#
# libretro-quicknes
#
################################################################################
# Version: Commits on May 27, 2023
LIBRETRO_QUICKNES_VERSION = 058d66516ed3f1260b69e5b71cd454eb7e9234a3 
LIBRETRO_QUICKNES_SITE = $(call github,libretro,QuickNES_Core,$(LIBRETRO_QUICKNES_VERSION))
LIBRETRO_QUICKNES_LICENSE = GPLv2

LIBRETRO_QUICKNES_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2835),y)
LIBRETRO_QUICKNES_PLATFORM = rpi1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2836),y)
LIBRETRO_QUICKNES_PLATFORM = rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2837),y)
LIBRETRO_QUICKNES_PLATFORM = rpi3_64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2711),y)
LIBRETRO_QUICKNES_PLATFORM = rpi4

else ifeq ($(BR2_aarch64),y)
LIBRETRO_QUICKNES_PLATFORM = unix

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S812),y)
LIBRETRO_QUICKNES_PLATFORM = armv

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RG35XX),y)
LIBRETRO_QUICKNES_PLATFORM = armv cortexa9 neon hardfloat
endif

define LIBRETRO_QUICKNES_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(LIBRETRO_QUICKNES_PLATFORM)" \
        GIT_VERSION="-$(shell echo $(LIBRETRO_QUICKNES_VERSION) | cut -c 1-7)"
endef

define LIBRETRO_QUICKNES_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/quicknes_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/quicknes_libretro.so
endef

$(eval $(generic-package))
