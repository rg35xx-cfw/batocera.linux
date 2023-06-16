################################################################################
#
# PowerVR SGX544 userspace gpu drivers (X11/GLX/FBDEV)
#
################################################################################
# Version.: Commits on June 15, 2023
POWERVR_SGX544_DRIVER_VERSION = 989041df5c242b4d114ab796d1a8f9504822a7af
POWERVR_SGX544_DRIVER_SITE = $(call github,rg35xx-cfw,cubieboard6_ubuntu_gpu_drivers,$(POWERVR_SGX544_DRIVER_VERSION))

POWERVR_SGX544_DRIVER_INSTALL_STAGING = YES
POWERVR_SGX544_DRIVER_PROVIDES = libegl libgles

define POWERVR_SGX544_DRIVER_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/lib/pkgconfig

        cp -rf $(@D)/include/* $(STAGING_DIR)/usr/include/

        $(INSTALL) -D -m 0644 $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/gpu/powervr-sgx544-driver/egl.pc \
                $(STAGING_DIR)/usr/lib/pkgconfig/egl.pc
        $(INSTALL) -D -m 0644 $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/gpu/powervr-sgx544-driver/glesv2.pc \
                $(STAGING_DIR)/usr/lib/pkgconfig/glesv2.pc
	cd $(@D)/v2 && ./install.sh --root $(STAGING_DIR)
endef

define POWERVR_SGX544_DRIVER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib
	cd $(@D)/v2 && ./install.sh --root $(TARGET_DIR)
endef

$(eval $(generic-package))
