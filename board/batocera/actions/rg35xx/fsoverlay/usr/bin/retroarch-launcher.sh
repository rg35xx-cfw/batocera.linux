#!/bin/sh

#export LD_LIBRARY_PATH=/usr/lib:/usr/local/XSGX/lib:/lib
#export DISPLAY=:0
export HOME=/userdata/system
export SDL_RENDER_DRIVER=opengles2
cd $HOME


BOOTCONF="/boot/batocera-boot.conf"
REBOOT_FLAG=/var/run/retroarch-launcher

if test "$1" = "--stop-rebooting"
then
    rm -f "${REBOOT_FLAG}"
    exit 0
fi

# flag to reboot at each stop
# es is stopped : in case of crash, in case of some options are changed (language, video mode)
touch "${REBOOT_FLAG}" || exit 1

# environment
export HOME=/userdata/system

#batocera-switch-screen-checker --init

# Start PVR 
/usr/local/bin/pvrsrvctl --start --no-module

LAUNCHER="emulationstation"
if [ -f /boot/startRA ]; then
        LAUNCHER="retroarch"
fi

GAMELAUNCH=1
while test -e "${REBOOT_FLAG}"
do
    if test "$LAUNCHER" = "retroarch"
    then
	cd $HOME
        retroarch --verbose
    else
	cd $HOME
	simplemenu
        #emulationstation 
	#--windowed
    fi
    GAMELAUNCH=0
done
exit 0

