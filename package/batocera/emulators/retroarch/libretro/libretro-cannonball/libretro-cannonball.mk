################################################################################
#
# libretro-cannonball
#
################################################################################
# Last commit: May 27, 2023
LIBRETRO_CANNONBALL_VERSION = 93ca14d7074b400fc3ed9ba8cefe0622f8d76176
LIBRETRO_CANNONBALL_SITE = $(call github,libretro,cannonball,$(LIBRETRO_CANNONBALL_VERSION))
LIBRETRO_CANNONBALL_LICENSE = GPLv3

LIBRETRO_CANNONBALL_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RG35XX),y)
LIBRETRO_CANNONBALL_PLATFORM = armv cortexa9 neon hardfloat
endif

define LIBRETRO_CANNONBALL_BUILD_CMDS
        $(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(LIBRETRO_CANNONBALL_PLATFORM)" \
        GIT_VERSION="-$(shell echo $(LIBRETRO_CANNONBALL_VERSION) | cut -c 1-7)"
endef

define LIBRETRO_CANNONBALL_INSTALL_TARGET_CMDS
        $(INSTALL) -D $(@D)/cannonball_libretro.so \
                $(TARGET_DIR)/usr/lib/libretro/cannonball_libretro.so
endef

$(eval $(generic-package))

