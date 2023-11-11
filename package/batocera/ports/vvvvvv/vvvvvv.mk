################################################################################
#
# VVVVVV
#
################################################################################
# Version.: Commits on Jun 24, 2020
VVVVVV_VERSION=916f182ce6df764283a7dd37ad681f5752e7503a
VVVVVV_SITE = $(call github,TerryCavanagh,VVVVVV,$(VVVVVV_VERSION))
VVVVVV_LICENSE="CUSTOM"
VVVVVV_DEPENDENCIES = sdl2
VVVVVV_SUBDIR = desktop_version

VVVVVV_CMAKE_OPTS = -DCMAKE_BUILD_TYPE=Release

define VVVVVV_INSTALL_TARGET_CMDS
        $(INSTALL) -m 0755 $(@D)/desktop_version/VVVVVV -D $(TARGET_DIR)/usr/bin/VVVVVV
endef

$(eval $(cmake-package))
