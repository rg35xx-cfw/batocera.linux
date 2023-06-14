################################################################################
#
# opencct2
#
################################################################################

OPENRCT2_VERSION = 9e4918c
OPENRCT2_SITE = $(call github,OpenRCT2,OpenRCT2,$(OPENRCT2_VERSION))
OPENRCT2_DEPENDENCIES = sdl2 sdl2_image json-for-modern-cpp
OPENRCT2_SUPPORTS_IN_SOURCE_BUILD = NO

OPENRCT2_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release -DRENDERER=GLES2 #-DDISABLE_GUI=ON


define OPENRCT2_INSTALL_TARGET_EVMAPY
	mkdir -p $(TARGET_DIR)/usr/share/evmapy
	cp $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/ports/opencct2/opencct2.keys $(TARGET_DIR)/usr/share/evmapy
endef

OPENRCT2_POST_INSTALL_TARGET_HOOKS = OPENRCT2_INSTALL_TARGET_EVMAPY

$(eval $(cmake-package))
