################################################################################
#
# libretro-vm
#
################################################################################
# Version: Commits on Jun 10, 2023
LIBRETRO_VM_VERSION = fb5d6ddabec23298db39ab8536f77623fb3a1bae
LIBRETRO_VM_SITE = $(call github,minkcv,vm,$(LIBRETRO_VM_VERSION))
LIBRETRO_VM_LICENSE = GPLv2

LIBRETRO_VM_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2835),y)
LIBRETRO_VM_PLATFORM = rpi1

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2836),y)
LIBRETRO_VM_PLATFORM = rpi2

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2837),y)
LIBRETRO_VM_PLATFORM = rpi3_64

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_BCM2711),y)
LIBRETRO_VM_PLATFORM = rpi4

else ifeq ($(BR2_aarch64),y)
LIBRETRO_VM_PLATFORM = unix

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S812),y)
LIBRETRO_VM_PLATFORM = armv

else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RG35XX),y)
LIBRETRO_VM_PLATFORM = armv cortexa9 neon hardfloat
endif

define LIBRETRO_VM_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) -f Makefile platform="$(LIBRETRO_VM_PLATFORM)" \
        GIT_VERSION="-$(shell echo $(LIBRETRO_VM_VERSION) | cut -c 1-7)"
endef

define LIBRETRO_VM_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/vm_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/vm_libretro.so
endef

$(eval $(generic-package))
