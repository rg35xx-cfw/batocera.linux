################################################################################
#
# spacecadet
#
################################################################################

SPACECADET_VERSION = e466bba
SPACECADET_SITE = $(call github,k4zmu2a,SpaceCadetPinball,$(SPACECADET_VERSION))
SPACECADET_DEPENDENCIES = sdl2 sdl2_image
SPACECADET_SUPPORTS_IN_SOURCE_BUILD = NO

define SPACECADET_INSTALL_TARGET_EVMAPY
	mkdir -p $(TARGET_DIR)/usr/share/evmapy
	cp $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/ports/spacecadet/spacecadet.keys $(TARGET_DIR)/usr/share/evmapy
endef

SPACECADET_POST_INSTALL_TARGET_HOOKS = SPACECADET_INSTALL_TARGET_EVMAPY

$(eval $(cmake-package))
