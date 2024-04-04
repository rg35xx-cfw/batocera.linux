#!/bin/bash

export HOME=/userdata/system
export GAMEDIR="/userdata/roms/ports/curseofissyos"
cd $GAMEDIR

export GMLOADER_DEPTH_DISABLE=1
export GMLOADER_SAVEDIR="$GAMEDIR/gamedata/"
export SDL_GAMECONTROLLERCONFIG=$(grep "Deeplay" "${HOME}/.config/gamecontrollerdb.txt")

chmod +x $GAMEDIR/gmloader

# Kill the evmapy utility if it's running

./gmloader IssyosWrapper.apk |& tee log.txt /dev/tty0
