#!/bin/sh

export SDL_GAMECONTROLLERCONFIG=$(grep "Deeplay" "${HOME}/.config/gamecontrollerdb.txt")

SDL_FULLSCREEN=1 SpaceCadetPinball

