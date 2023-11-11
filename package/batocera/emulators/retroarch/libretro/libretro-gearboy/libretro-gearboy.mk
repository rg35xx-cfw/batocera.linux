################################################################################
#
# libretro-gearboy
#
################################################################################
# Version: Commits on Mar 12, 2023
LIBRETRO_GEARBOY_VERSION = 8161290995c685de47db8f72fc17ecc7f7e006a1
LIBRETRO_GEARBOY_SITE = $(call github,drhelius,Gearboy,$(LIBRETRO_GEARBOY_VERSION))
LIBRETRO_GEARBOY_LICENSE = GPLv3

define LIBRETRO_GEARBOY_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C \
        $(@D)/platforms/libretro -f Makefile platform="unix"
endef

define LIBRETRO_GEARBOY_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/platforms/libretro/gearboy_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/gearboy_libretro.so
endef

$(eval $(generic-package))
