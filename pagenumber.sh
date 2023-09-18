#!/bin/sh

PID=$(pidof zathura)
if [ $? -ne 0 ]; then
	echo "No instance running?"
	exit 1
fi

busctl get-property --user "org.pwmt.zathura.PID-$PID" /org/pwmt/zathura org.pwmt.zathura pagenumber 2>/dev/null
