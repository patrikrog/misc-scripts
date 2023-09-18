#!/usr/bin/env bash

local wineprefix="$HOME/eac-prefix"
local eacdir="${wineprefix}/drive_c/Program Files/Exact Audio Copy"
pushd "${eacdir}/Microsoft.VC80.CRT"
WINEPREFIX=$wineprefix WINEDEBUG=-all wine "${eacdir}/EAC.exe"
popd
