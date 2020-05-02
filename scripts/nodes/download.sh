#!/bin/bash
export VERSION=v1.12.0

if [[ $1 ]]; then
    VERSION=$1
fi

export URL=https://github.com/hypriot/image-builder-rpi/releases/download/$VERSION/hypriotos-rpi-$VERSION.img.zip
export FILENAME=hypriotos-rpi-$VERSION.img.zip

echo Downloading hypriot/image-builder-rpi $VERSION
mkdir downloads
cd downloads
curl -Lo $FILENAME $URL
unzip $FILENAME
rm $FILENAME
