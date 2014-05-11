#!/bin/bash

if [ "$#" -ne 1 ]
then
    echo "Usage: build.sh [xo version]"
    exit 1
fi

for i in $(seq 5 $END)
do
    test -b /dev/loop$i || mknod /dev/loop$i b 7 $i
done

olpc-os-builder xugar-1.0.0-xo$1.ini
