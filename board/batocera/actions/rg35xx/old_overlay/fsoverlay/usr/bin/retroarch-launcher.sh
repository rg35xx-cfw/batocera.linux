#!/bin/sh

export LD_LIBRARY_PATH=/usr/local/XSGX/lib:/lib:/usr/lib
export DISPLAY=:0
export HOME=/userdata/system
export SDL_RENDER_DRIVER=opengles
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

batocera-switch-screen-checker --init

GAMELAUNCH=1
while test -e "${REBOOT_FLAG}"
do
    retroarch --verbose
#    emulationstation --windowed 
    GAMELAUNCH=0
done
exit 0

