#!/bin/bash
JCDIR="$HOME/jc141"; JCPRF="$HOME/jc141/prefix.dwarfs";

mount-game() {
    [ ! -f "$BINDIR/$BIN" ] && mkdir -p {"$PWD/files/groot-mnt","$PWD/files/groot-rw","$PWD/files/groot-work","$R/files/groot"} && dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/groot-mnt" && fuse-overlayfs -o lowerdir="$PWD/files/groot-mnt",upperdir="$PWD/files/groot-rw",workdir="$PWD/files/groot-work" "$PWD/files/groot"
    echo "DWRFS: Mounted game."
}

mount-prefix() {
    [ ! -d "$JCDIR" ] && mkdir -p "$JCDIR"; export WINEPREFIX="$HOME/jc141/prefix"
    [ ! -f "$JCPRF" ] && wineboot -e -u && sleep 5 && mkdwarfs -l7 -B5 -i "$HOME/jc141/prefix" -o "$JCDIR/prefix.dwarfs" && rm -Rf "$WINEPREFIX"
    export WINEPREFIX="$PWD/files/data/prefix-tmp"
    [ ! -d "$WINEPREFIX" ] && mkdir -p {"$JCDIR/prefix-mnt","$PWD/files/data/user-data","$PWD/files/data/work","$PWD/files/data/prefix-tmp"} && dwarfs "$JCDIR/prefix.dwarfs" "$JCDIR/prefix-mnt" -o cache_image && fuse-overlayfs -o lowerdir="$JCDIR/prefix-mnt",upperdir="$PWD/files/data/user-data",workdir="$PWD/files/data/work" "$PWD/files/data/prefix-tmp";
    echo "DWRFS: Mounted prefix."
}

unmount-game() {
    wineserver -k && fuser -k "$PWD/files/groot-mnt"
    [ -d "$PWD/files/groot" ] && fusermount -u "$PWD/files/groot"
    [ -d "$PWD/files/groot-mnt" ] && fusermount -u "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-mnt"
    echo "DWRFS: Unmounted game."
}

unmount-prefix() {
    wineserver -k && sleep 3 && fuser -k "$JCDIR/prefix-mnt"
    sleep 3 && fusermount -u "$PWD/files/data/prefix-tmp" && rm -d -f "$PWD/files/data/prefix-tmp";
    sleep 3 && fusermount -u "$JCDIR/prefix-mnt" && rm -d -f "$JCDIR/prefix-mnt"
    echo "DWRFS: Unmounted prefix."
}

extract-game() {
    [ ! -d "$PWD/files/groot" ] && echo "DWRFS: Extracting game, this may take a while. Do not cancel the process or the files will be incomplete."; tstart="$(date +%s)" && mkdir "$PWD/files/groot" && dwarfsextract -i "$PWD/files/groot.dwarfs" -o "$PWD/files/groot" && tend="$(date +%s)"; elapsed="$((tend - tstart))" && echo "done in $((elapsed / 60)) min and $((elapsed % 60)) sec"
}

"$1"
