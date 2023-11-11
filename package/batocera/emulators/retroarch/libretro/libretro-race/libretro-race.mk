################################################################################
#
# libretro-race
#
################################################################################
# Version: Commits on May 27, 2023
LIBRETRO_RACE_VERSION = f65011e6639ccbbbb44b6ffa63ca50c070475df4
LIBRETRO_RACE_SITE = $(call github,libretro,RACE,$(LIBRETRO_RACE_VERSION))
LIBRETRO_RACE_LICENSE = GPLv2

LIBRETRO_RACE_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2835),y)
LIBRETRO_RACE_PLATFORM = rpi1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2836),y)
LIBRETRO_RACE_PLATFORM = rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2837),y)
LIBRETRO_RACE_PLATFORM = rpi3_64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2711),y)
LIBRETRO_RACE_PLATFORM = rpi4

else ifeq ($(BR2_aarch64),y)
LIBRETRO_RACE_PLATFORM = unix

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S812),y)
LIBRETRO_RACE_PLATFORM = armv

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RG35XX),y)
LIBRETRO_RACE_PLATFORM = armv cortexa9 neon hardfloat
endif

define LIBRETRO_RACE_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(LIBRETRO_RACE_PLATFORM)" \
        GIT_VERSION="-$(shell echo $(LIBRETRO_RACE_VERSION) | cut -c 1-7)"
endef

define LIBRETRO_RACE_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/race_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/race_libretro.so
endef

$(eval $(generic-package))
