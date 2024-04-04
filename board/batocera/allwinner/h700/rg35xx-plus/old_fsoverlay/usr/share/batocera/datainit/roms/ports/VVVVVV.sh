#!/bin/bash

export PORTS_FOLDER=$(realpath $(dirname ${BASH_SOURCE[0]}))
export GAMEDIR="${PORTS_FOLDER}/VVVVVV"
cd $GAMEDIR

export SDL_GAMECONTROLLERCONFIG=$(grep Deeplay "${HOME}/.config/gamecontrollerdb.txt")
chmod +x $GAMEDIR/VVVVVV

env \
        LD_LIBRARY_PATH="${GAMEDIR}/VVVVVV" \
        ./VVVVVV \
                -basedir ${GAMEDIR}/ \
                -assets ${GAMEDIR}/data.zip \
                -langdir ${GAMEDIR}/lang/ \
                -fontsdir ${GAMEDIR}/fonts/
