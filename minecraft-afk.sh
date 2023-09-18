#!/bin/sh

while true; do
    window_id=$(xdotool search "GregBlock")
    xdotool mousedown --window $window_id 1;
    sleep 5;
done
