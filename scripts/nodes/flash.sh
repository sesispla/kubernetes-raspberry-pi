#!/bin/bash
export VERSION=v1.12.0
export IMG=downloads/hypriotos-rpi-$VERSION.img
#export DEVICE=/dev/disk2 # Use at your own risk! Put your SD device here and uncomment to perform an unattended flash

if [[ $1 ]]; then
    VERSION=$1
fi

if [ ! -f "$IMG" ]; then
    ./download.sh $VERSION
fi

if [[ $DEVICE ]]; then
    flash -d $DEVICE -f $IMG
else
    flash $IMG
fi