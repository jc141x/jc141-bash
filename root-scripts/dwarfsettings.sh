#!/bin/bash

# defaults
export WINEPREFIX="$PWD/files/prefix"

mount() {
    mkdir -p {"$PWD/files/groot-mnt","$PWD/files/groot-rw","$PWD/files/groot-work","$PWD/files/groot"} && dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/groot-mnt" && fuse-overlayfs -o lowerdir="$PWD/files/groot-mnt",upperdir="$PWD/files/groot-rw",workdir="$PWD/files/groot-work" "$PWD/files/groot"
}

force-unmount() {
    wineserver -k && fuser -k "$F/groot-mnt"
    [ -d "$PWD/files/groot" ] && fusermount -u "$PWD/files/groot"
    [ -d "$PWD/files/groot-mnt" ] && fusermount -u "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-mnt"
}

extract() {
    echo "extracting game root..."; tstart="$(date +%s)"
    [ ! -d "$PWD/files/groot" ] && mkdir "$PWD/files/groot"
    dwarfsextract -i "$PWD/files/groot.dwarfs" -o "$PWD/files/groot"
    tend="$(date +%s)"; elapsed="$((tend - tstart))"
    echo "done in $((elapsed / 60)) min and $((elapsed % 60)) sec"
}

"$1"
