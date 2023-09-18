#!/bin/sh

egrep -i "[0-9]{2}\/[0-9]{2}\/[0-9]{4}" ~/.org/skola.org | awk -F' ' '{printf "%-12s - %s, %s-%s\n", $4, $6, $8, $NF}' | sort -b -k3.7,3.10 -k3.4,3.5 -k3.1,3.2
