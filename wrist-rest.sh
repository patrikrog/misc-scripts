#!/bin/sh
export XDG_RUNTIME_DIR=/run/user/$(id -u)

pgrep "slock";

if [ $? != 0 ]
then
    notify-send -u "critical" "Ta en paus" "Vila handlederna, sträck på dig"
fi
