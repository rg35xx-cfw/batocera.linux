################################################################################
#
# libretro-meteor
#
################################################################################
# Last commit: Dec 28, 2020
LIBRETRO_METEOR_VERSION = e533d300d0561564451bde55a2b73119c768453c
LIBRETRO_METEOR_SITE = $(call github,libretro,meteor-libretro,$(LIBRETRO_METEOR_VERSION))
LIBRETRO_METEOR_LICENSE = GPLv3

LIBRETRO_METEOR_DEPENDENCIES = 

LIBRETRO_METEOR_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release \
    -DPLAYER_TARGET_PLATFORM=libretro -DBUILD_SHARED_LIBS=ON
LIBRETRO_METEOR_CONF_ENV += LDFLAGS="-lpthread -fPIC" CFLAGS="-fPIC" CXX_FLAGS="-fPIC"

define LIBRETRO_METEOR_INSTALL_TARGET_CMDS
    $(INSTALL) -D $(@D)/buildroot-build/meteor_libretro.so \
    $(TARGET_DIR)/usr/lib/libretro/meteor_libretro.so
endef

$(eval $(cmake-package))
