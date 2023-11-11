################################################################################
#
# libretro-mame2003-xtreme
#
################################################################################
# Version: Commits on Feb 21, 2023
LIBRETRO_MAME2003_XTREME_VERSION = ca7712a5488b27ab7fdec1c51a17a8edf21f9f23
LIBRETRO_MAME2003_XTREME_SITE = $(call github,KMFDManic,mame2003-xtreme,$(LIBRETRO_MAME2003_XTREME_VERSION))
LIBRETRO_MAME2003_XTREME_LICENSE = MAME

LIBRETRO_MAME2003_XTREME_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2835),y)
LIBRETRO_MAME2003_XTREME_PLATFORM = rpi1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2836),y)
LIBRETRO_MAME2003_XTREME_PLATFORM = rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2837),y)
LIBRETRO_MAME2003_XTREME_PLATFORM = rpi3_64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2711),y)
LIBRETRO_MAME2003_XTREME_PLATFORM = rpi4_64

else ifeq ($(BR2_aarch64),y)
LIBRETRO_MAME2003_XTREME_PLATFORM = unix

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S812),y)
LIBRETRO_MAME2003_XTREME_PLATFORM = s812
LIBRETRO_MAME2003_XTREME_EXTRA_ARGS = HAS_CYCLONE=1 HAS_DRZ80=1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RG35XX),y)
LIBRETRO_MAME2003_XTREME_PLATFORM = unix armv neon hardfloat
LIBRETRO_MAME2003_XTREME_EXTRA_ARGS = HAS_CYCLONE=1 HAS_DRZ80=1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ORANGEPI_PC)$(BR2_PACKAGE_BATOCERA_TARGET_CHA)$(BR2_PACKAGE_BATOCERA_TARGET_RK3128),y)
LIBRETRO_MAME2003_XTREME_PLATFORM = rpi2
LIBRETRO_MAME2003_XTREME_EXTRA_ARGS = HAS_CYCLONE=1 HAS_DRZ80=1
endif

define LIBRETRO_MAME2003_XTREME_BUILD_CMDS
	mkdir -p $(@D)/obj/mame/cpu/ccpu
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ -f Makefile platform="$(LIBRETRO_MAME2003_XTREME_PLATFORM)" \
        GIT_VERSION=" $(shell echo $(LIBRETRO_MAME2003_XTREME_VERSION) | cut -c 1-7)"
endef

define LIBRETRO_MAME2003_XTREME_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/km_mame2003_xtreme_amped_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/km_mame2003_xtreme_amped_libretro.so

	# Bios
    # Need to think of another way to use these files.
    # They take up a lot of space on tmpfs.
	mkdir -p $(TARGET_DIR)/usr/share/batocera/datainit/bios/mame2003-xtreme/samples
	cp -r $(@D)/metadata/* \
		$(TARGET_DIR)/usr/share/batocera/datainit/bios/mame2003-xtreme
endef

define LIBRETRO_MAME2003_XTREME_NAMCO_QUICK_FIX
	$(SED) 's|O3|O2|g' $(@D)/Makefile
	$(SED) 's|to continue|on Keyboard, or Left, Right on Joystick to continue|g' $(@D)/src/ui_text.c
endef

LIBRETRO_MAME2003_XTREME_PRE_BUILD_HOOKS += LIBRETRO_MAME2003_XTREME_NAMCO_QUICK_FIX

$(eval $(generic-package))
