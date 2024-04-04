#!/bin/sh

#export LD_LIBRARY_PATH=/usr/lib:/usr/local/XSGX/lib:/lib
export HOME=/userdata/system
cd $HOME

# paclt sinks fix
/etc/init.d/S06audio restart

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

CUSTOM_LAUNCHER_FILE="/userdata/system/customlauncher"

LAUNCHER="emulationstation"

if [ -f "${CUSTOM_LAUNCHER_FILE}" ]; then
    # Read the content of the file
    LAUNCHER=$(cat "${CUSTOM_LAUNCHER_FILE}")
fi

GAMELAUNCH=1
while test -e "${REBOOT_FLAG}"
do
    if test "$LAUNCHER" = "retroarch"
    then
        cd "$HOME"
        retroarch --verbose
    elif test "$LAUNCHER" = "emulationstation"
    then
        cd "$HOME"
        emulationstation-standalone
    else
        cd "$HOME"
        "$LAUNCHER"
    fi
    GAMELAUNCH=0
done
exit 0

