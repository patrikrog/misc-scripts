#!/bin/bash
for file in $1/*.vgm
do
        filename=`basename "$file" .vgm`
        echo "$filename"
        #vgm2wav "$file" "$filename.wav"
done
