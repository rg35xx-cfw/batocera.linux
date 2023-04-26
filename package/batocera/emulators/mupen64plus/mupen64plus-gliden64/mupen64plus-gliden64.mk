################################################################################
#
# mupen64plus-gliden64-plugin
#
################################################################################
# Version.: Commits on Feb 25, 2023
MUPEN64PLUS_GLIDEN64_VERSION = 1f4d04f43b53739bc9b128ab5577d20e3d60ed6a
MUPEN64PLUS_GLIDEN64_SITE = $(call github,gonetz,GLideN64,$(MUPEN64PLUS_GLIDEN64_VERSION))
MUPEN64PLUS_GLIDEN64_LICENSE = GPLv2
MUPEN64PLUS_GLIDEN64_DEPENDENCIES = sdl2 alsa-lib mupen64plus-core libpng zlib
MUPEN64PLUS_GLIDEN64_CONF_OPTS = -DMUPENPLUSAPI=ON -DUSE_SYSTEM_LIBS=ON -DUNIX=ON -DVEC4_OPT=ON -DMUPENPLUSAPI_GLIDENUI=OFF
MUPEN64PLUS_GLIDEN64_SUBDIR = /src/

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
	MUPEN64PLUS_GLIDEN64_DEPENDENCIES += rpi-userland
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_X86_ANY),y)
	MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DX86_OPT=ON
endif

ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
	MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DEGL=ON -DGL_PROFILE=ON
	MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DCMAKE_C_FLAGS="-DEGL_NO_X11"
	MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DCMAKE_CXX_FLAGS="-DEGL_NO_X11"
endif

ifeq ($(BR2_PACKAGE_MESA3D),y)
	MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DMESA=ON
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
#	MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DNEON_OPT=ON
endif

ifeq ($(BR2_arm),y)
	MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DCRC_OPT=ON
endif

ifeq ($(BR2_aarch64),y)
	MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DCRC_ARMV8=ON
endif

ifeq ($(BR2_PACKAGE_SDL2_KMSDRM)$(BR2_PACKAGE_SDL2_WAYLAND),y)
	MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DSDL=ON
endif

ifeq ($(BR2_ENABLE_DEBUG),y)
	MUPEN64PLUS_GLIDEN64_RELTYPE= Debug
	MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
else
	MUPEN64PLUS_GLIDEN64_RELTYPE = Release
	MUPEN64PLUS_GLIDEN64_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
endif

define MUPEN64PLUS_GLIDEN64_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/share/mupen64plus/
	$(INSTALL) -D $(@D)/src/plugin/$(MUPEN64PLUS_GLIDEN64_RELTYPE)/mupen64plus-video-GLideN64.so \
		$(TARGET_DIR)/usr/lib/mupen64plus/mupen64plus-video-gliden64.so
	$(INSTALL) -D $(@D)/ini/* \
		$(TARGET_DIR)/usr/share/mupen64plus/
endef

# define MUPEN64PLUS_GLIDEN64_PRE_CONFIGURE_FIXUP
#	chmod +x $(@D)/src/getRevision.sh
#	sh $(@D)/src/getRevision.sh
#	$(SED) 's|.{CMAKE_FIND_ROOT_PATH}/opt/vc/include|$(STAGING_DIR)/usr/include|g' $(@D)/src/CMakeLists.txt
#	$(SED) 's|.{CMAKE_FIND_ROOT_PATH}/opt/vc/lib|$(STAGING_DIR)/usr/lib|g' $(@D)/src/CMakeLists.txt
# endef

# MUPEN64PLUS_GLIDEN64_PRE_CONFIGURE_HOOKS += MUPEN64PLUS_GLIDEN64_PRE_CONFIGURE_FIXUP

$(eval $(cmake-package))
