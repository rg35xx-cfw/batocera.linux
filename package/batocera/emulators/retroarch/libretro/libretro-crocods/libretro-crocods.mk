################################################################################
#
# libretro-crocods
#
################################################################################
# Version: Commits on Jul 29, 2022
LIBRETRO_CROCODS_VERSION = f1b4b91291ba1e8e7c0be02269cd0d75c7fa71b9 
LIBRETRO_CROCODS_SITE = $(call github,libretro,libretro-crocods,$(LIBRETRO_CROCODS_VERSION))
LIBRETRO_CROCODS_LICENSE = GPLv2

LIBRETRO_CROCODS_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2835),y)
LIBRETRO_CROCODS_PLATFORM = rpi1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2836),y)
LIBRETRO_CROCODS_PLATFORM = rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2837),y)
LIBRETRO_CROCODS_PLATFORM = rpi3_64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2711),y)
LIBRETRO_CROCODS_PLATFORM = rpi4_64

else ifeq ($(BR2_cortex_a35)$(BR2_cortex_a53)$(BR2_arm),yy)
LIBRETRO_CROCODS_PLATFORM = armv neon
endif

define LIBRETRO_CROCODS_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_CROCODS_PLATFORM)" \
        GIT_VERSION="-$(shell echo $(LIBRETRO_CROCODS_VERSION) | cut -c 1-7)"
endef

define LIBRETRO_CROCODS_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/crocods_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/crocods_libretro.so
	cp -f $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/emulators/retroarch/libretro/libretro-crocods/amstradcpc.keys $(TARGET_DIR)/usr/share/evmapy/
endef

$(eval $(generic-package))
