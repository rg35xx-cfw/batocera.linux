################################################################################
#
# PUAE
#
################################################################################
# Version.: Commits on Nov 16, 2020
LIBRETRO_PUAE_VERSION = 6f669cc2d5045a47f1eabbbb35e2ea6956cf485b
LIBRETRO_PUAE_SITE = $(call github,libretro,libretro-uae,$(LIBRETRO_PUAE_VERSION))
LIBRETRO_PUAE__LICENSE = GPLv2

PUAEPLATFORM=$(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	PUAEPLATFORM=rpi
endif

define LIBRETRO_PUAE_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" GIT_VERSION=" e187a6" -C $(@D)/ -f Makefile platform="$(PUAEPLATFORM)"
endef

define LIBRETRO_PUAE_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/puae_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/puae_libretro.so
endef

$(eval $(generic-package))
