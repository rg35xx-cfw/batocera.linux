################################################################################
#
# PowerVR SGX544 userspace gpu drivers (X11/GLX)
#
################################################################################
# Version.: Commits on March 31, 2023
POWERVR_SGX544_DRIVER_VERSION = 8c46eca
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

	$(@D)/v2/install.sh --root $(STAGING_DIR)
	ln -s $(STAGING_DIR)/usr/lib/libGLES_CM.so $(STAGING_DIR)/usr/lib/libGLESv1_CM.so
	ln -s $(STAGING_DIR)/usr/lib/libGLES_CM.so $(STAGING_DIR)/usr/lib/libGLESv1_CM.so.1

endef

define POWERVR_SGX544_DRIVER_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib
	$(@D)/v2/install.sh --root $(TARGET_DIR)
	
	cd $(TARGET_DIR)/usr/lib
	ln -s libGLES_CM.so libGLESv1_CM.so
	ln -s libGLES_CM.so libGLESv1_CM.so.1
endef

$(eval $(generic-package))
