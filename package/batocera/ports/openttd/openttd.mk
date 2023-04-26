################################################################################
#
# openttd
#
################################################################################

OPENTTD_VERSION = db573c8
OPENTTD_SITE = $(call github,OpenTTD,OpenTTD,$(OPENTTD_VERSION))
OPENTTD_DEPENDENCIES = sdl2 sdl2_image
OPENTTD_SUPPORTS_IN_SOURCE_BUILD = NO

define OPENTTD_INSTALL_TARGET_EVMAPY
	mkdir -p $(TARGET_DIR)/usr/share/evmapy
	cp $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/ports/openttd/openttd.keys $(TARGET_DIR)/usr/share/evmapy
endef

OPENTTD_POST_INSTALL_TARGET_HOOKS = OPENTTD_INSTALL_TARGET_EVMAPY

$(eval $(cmake-package))
