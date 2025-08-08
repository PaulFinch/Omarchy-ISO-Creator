#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

if ! command -v mkarchiso >/dev/null 2>&1; then
    echo "Error: mkarchiso command not found. Install 'archiso' package first."
    exit 1
fi

# CLEAN
[ -d ./releng ] && rm -rf ./releng
[ -d ./working ] && rm -rf ./working
[ -d ./output ] && rm -rf ./output
[ -d ./output ] || mkdir ./output
[ -d ./working ] || mkdir ./working

# MAKE ISO
cp -rf /usr/share/archiso/configs/releng .
cp -rf ./config/* ./releng/
mkarchiso -v -w ./working -o ./output ./releng

# CLEAN
rm -rf ./releng
rm -rf ./working
chown -R $(logname):$(logname) ./output
chmod 755 ./output

exit 0