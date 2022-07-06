#!/bin/bash
RMTDIR="${XDG_DATA_HOME:-$HOME/.local/share}/rumtricks"; RMTCONTENT="$RMTDIR/rumtricks-content"; RMTARCH="rumtricks-content.tar.lzma";
PRF="$RMTDIR/prefix.dwarfs"; RMT="$RMTDIR/rumtricks.sh";

mount-game() { [ -d "$PWD/files/groot-mnt" ] && unmount-game;
[ -d "$PWD/files/groot" ] && echo "DWRFS: Mounting path exists." && [ "$( ls -A "$PWD/files/groot")" ] && echo "DWRFS: Game is already mounted or extracted." && exit
mkdir -p {"$PWD/files/groot-mnt","$PWD/files/groot-rw","$PWD/files/groot-work","$PWD/files/groot"} && dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/groot-mnt" && fuse-overlayfs -o lowerdir="$PWD/files/groot-mnt",upperdir="$PWD/files/groot-rw",workdir="$PWD/files/groot-work" "$PWD/files/groot" && echo "DWRFS: Mounted game."; }

mount-prefix() { [ -d "$RMTDIR/prefix-mnt" ] && unmount-prefix;
# downloading
RMTRLS="$(curl -s https://api.github.com/repos/jc141x/rumtricks/releases/latest)"
DLRLS="$(echo "$RMTRLS" | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}')"
[ ! -f "$RMTDIR/$RMTARCH" ] && [ ! -d "$RMTCONTENT" ] && curl -L "$DLRLS" -o "$RMTDIR/$RMTARCH" && [ ! -f "$RMTDIR/$RMTARCH" ] && echo "RMT: Download failed. " && exit || [ ! -d "$RMTCONTENT" ] && tar -xvf "$RMTDIR/$RMTARCH" -C "$RMTDIR" && rm -Rf "$RMTDIR/$RMTARCH"

# prefix generation
[ -f "$PRF" ] && find "$RMTDIR/prefix.dwarfs" -mtime +60 -type f -delete; export WINEPREFIX="$RMTDIR/prefix"; [ ! -f "$RMT" ] && cp "$PWD/files/rumtricks.sh" "$RMT";
[ ! -f "$PRF" ] && WINEPREFIX="$RMTDIR/prefix" bash "$RMT" directx vcrun && sleep 2 && mkdwarfs -l7 -B5 -i "$RMTDIR/prefix" -o "$RMTDIR/prefix.dwarfs" && rm -Rf "$WINEPREFIX"

# mounting prefix
[ ! -d "$WINEPREFIX" ] && mkdir -p {"$RMTDIR/prefix-mnt","$PWD/files/data/user-data","$PWD/files/data/work","$PWD/files/data/prefix-tmp"} && dwarfs "$RMTDIR/prefix.dwarfs" "$RMTDIR/prefix-mnt" -o cache_image && fuse-overlayfs -o lowerdir="$RMTDIR/prefix-mnt",upperdir="$PWD/files/data/user-data",workdir="$PWD/files/data/work" "$PWD/files/data/prefix-tmp";
echo "DWRFS: Mounted prefix."; }

unmount-game() { wineserver -k && killall gamescope && fuser -k "$PWD/files/groot-mnt"
fusermount -u -z "$PWD/files/groot"
fusermount -u -z "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-work"
echo "DWRFS: Unmounted game."; }

unmount-prefix() { wineserver -k && fuser -k "$RMTDIR/prefix-mnt"
fusermount -u -z "$PWD/files/data/prefix-tmp" && rm -d -f "$PWD/files/data/prefix-tmp";
fusermount -u -z "$RMTDIR/prefix-mnt" && rm -d -f "$RMTDIR/prefix-mnt"
echo "DWRFS: Unmounted prefix."; }

extract-game() { [ -d "$PWD/files/groot" ] && echo "DWRFS: Extraction path exists." && [ "$( ls -A "$PWD/files/groot")" ] && echo "DWRFS: Game is already mounted or extracted." && exit
rm -d "$PWD/files/groot" && echo "DWRFS: Extracting game, this may take a while. Do not cancel the process or the files will be incomplete."; tstart="$(date +%s)" && mkdir "$PWD/files/groot" && dwarfsextract -i "$PWD/files/groot.dwarfs" -o "$PWD/files/groot" && tend="$(date +%s)"; elapsed="$((tend - tstart))" && echo "DWRFS: Done in $((elapsed / 60)) min and $((elapsed % 60)) sec"; }

for i in "$@"; do
    # Check if function exists
    if type "$i" &>/dev/null; then
        "$i"
    else exit
    fi
done
