################################################################################
#
# libretro-gme
#
################################################################################
# Version: Commits on May 27, 2023
LIBRETRO_GME_VERSION = 40d8b3bf4f0bd4f713f65e08c62d30b1ae8b2282
LIBRETRO_GME_SITE = $(call github,libretro,libretro-gme,$(LIBRETRO_GME_VERSION))
LIBRETRO_GME_LICENSE = GPLv2

LIBRETRO_GME_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2835),y)
LIBRETRO_GME_PLATFORM = rpi1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2836),y)
LIBRETRO_GME_PLATFORM = rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2837),y)
LIBRETRO_GME_PLATFORM = rpi3_64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2711),y)
LIBRETRO_GME_PLATFORM = rpi4

else ifeq ($(BR2_aarch64),y)
LIBRETRO_GME_PLATFORM = unix

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S812),y)
LIBRETRO_GME_PLATFORM = armv

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RG35XX),y)
LIBRETRO_GME_PLATFORM = armv cortexa9 neon hardfloat
endif

define LIBRETRO_GME_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(LIBRETRO_GME_PLATFORM)" \
        GIT_VERSION="-$(shell echo $(LIBRETRO_GME_VERSION) | cut -c 1-7)"
endef

define LIBRETRO_GME_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/gme_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/gme_libretro.so
endef

$(eval $(generic-package))
