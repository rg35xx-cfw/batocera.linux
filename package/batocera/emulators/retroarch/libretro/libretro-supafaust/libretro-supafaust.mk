################################################################################
#
# libretro-supafaust
#
################################################################################
# Version: Commits on Apr 21, 2023
LIBRETRO_SUPAFAUST_VERSION = 75c658cce454e58ae04ea252f53a31c60d61548e
LIBRETRO_SUPAFAUST_SITE = $(call github,libretro,supafaust,$(LIBRETRO_SUPAFAUST_VERSION))
LIBRETRO_SUPAFAUST_LICENSE = Non-commercial

LIBRETRO_SUPAFAUST_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S922X),y)
LIBRETRO_SUPAFAUST_PLATFORM = CortexA73_G12B

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2835),y)
LIBRETRO_SUPAFAUST_PLATFORM = rpi1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2836),y)
LIBRETRO_SUPAFAUST_PLATFORM = rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2711),y)
LIBRETRO_SUPAFAUST_PLATFORM = rpi4_64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RG35XX),y)
LIBRETRO_SUPAFAUST_PLATFORM = armv cortexa9 neon hardfloat

else ifeq ($(BR2_aarch64),y)
LIBRETRO_SUPAFAUST_PLATFORM = unix
endif

define LIBRETRO_SUPAFAUST_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" \
    -C $(@D) -f Makefile platform="$(LIBRETRO_SUPAFAUST_PLATFORM)" \
        GIT_VERSION="-$(shell echo $(LIBRETRO_SUPAFAUST_VERSION) | cut -c 1-7)"
endef

define LIBRETRO_SUPAFAUST_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mednafen_supafaust_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mednafen_supafaust_libretro.so
endef

$(eval $(generic-package))
