#!/bin/bash
JCDIR="$HOME/jc141"; JCPRF="$HOME/jc141/prefix.dwarfs"; RMT="$JCDIR/rumtricks.sh";

mount-game() {
    [ ! -e "$BINDIR/$BIN" ] && mkdir -p {"$PWD/files/groot-mnt","$PWD/files/groot-rw","$PWD/files/groot-work","$PWD/files/groot"} && dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/groot-mnt" && fuse-overlayfs -o lowerdir="$PWD/files/groot-mnt",upperdir="$PWD/files/groot-rw",workdir="$PWD/files/groot-work" "$PWD/files/groot"
    echo "DWRFS: Mounted game."
}

mount-prefix() {
    [ -f "$JCPRF" ] && find "$JCDIR/prefix.dwarfs" -mtime +60 -type f -delete
    [ ! -d "$JCDIR" ] && mkdir -p "$JCDIR"; export WINEPREFIX="$HOME/jc141/prefix"
    [ ! -e "$RMT" ] && cp "$PWD/files/rumtricks.sh" "$RMT";
    [ ! -f "$JCPRF" ] && WINEPREFIX="$JCDIR/prefix" bash "$RMT" directx vcrun2003 vcrun2005 vcrun2008 vcrun2010 vcrun2012 vcrun2013 vcrun2015 vcrun2017 vcrun2019 && sleep 2 && mkdwarfs -l7 -B5 -i "$HOME/jc141/prefix" -o "$JCDIR/prefix.dwarfs" && rm -Rf "$WINEPREFIX"
    export WINEPREFIX="$PWD/files/data/prefix-tmp"
    [ ! -d "$WINEPREFIX" ] && mkdir -p {"$JCDIR/prefix-mnt","$PWD/files/data/user-data","$PWD/files/data/work","$PWD/files/data/prefix-tmp"} && dwarfs "$JCDIR/prefix.dwarfs" "$JCDIR/prefix-mnt" -o cache_image && fuse-overlayfs -o lowerdir="$JCDIR/prefix-mnt",upperdir="$PWD/files/data/user-data",workdir="$PWD/files/data/work" "$PWD/files/data/prefix-tmp";
    echo "DWRFS: Mounted prefix."
}

unmount-game() {
    wineserver -k && sleep 1 && fuser -k "$PWD/files/groot-mnt"
    [ -d "$PWD/files/groot" ] && sleep 3 && fusermount -u "$PWD/files/groot"
    [ -d "$PWD/files/groot-mnt" ] && sleep 3 && fusermount -u "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-mnt"
    echo "DWRFS: Unmounted game."
}

unmount-prefix() {
    wineserver -k && sleep 2 && fuser -k "$JCDIR/prefix-mnt"
    fusermount -u "$PWD/files/data/prefix-tmp" && rm -d -f "$PWD/files/data/prefix-tmp";
    fusermount -u "$JCDIR/prefix-mnt" && rm -d -f "$JCDIR/prefix-mnt"
    echo "DWRFS: Unmounted prefix."
}

extract-game() {
    [ ! -d "$PWD/files/groot" ] && echo "DWRFS: Extracting game, this may take a while. Do not cancel the process or the files will be incomplete."; tstart="$(date +%s)" && mkdir "$PWD/files/groot" && dwarfsextract -i "$PWD/files/groot.dwarfs" -o "$PWD/files/groot" && tend="$(date +%s)"; elapsed="$((tend - tstart))" && echo "done in $((elapsed / 60)) min and $((elapsed % 60)) sec"
}

for i in "$@"; do
    # Check if function exists
    if type "$i" &>/dev/null; then
        "$i"
    else
        echo "WARN: Command: '$i' does not exists. Try another command/option."
        echo
        print-usage
    fi
done
