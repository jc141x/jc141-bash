#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ ! -d "$JCD" ] && mkdir -p "$JCD"; F="$PWD/files"; BASE="$JCD/base"; BASEARCH="$JCD/base.tar.xz";
PRF="$JCD/prefix-v2.dwarfs"; BASEINSTALL="$JCD/base/install.sh"; GAME="$F/groot.dwarfs"; GRT="$F/groot"; PRFMT="$JCD/prefix-mnt"; GMNT="$F/groot-mnt"

# bindtointerface
BTI="$JCD/bindToInterface.so"; BTIARCH="$JCD/bindToInterface.tar.xz";
[ -f "/opt/jc141-bash/base.tar.xz" ] && rm -Rf "$BASEARCH" && ln -s "/opt/jc141-bash/base.tar.xz" "$BASEARCH"
[ ! -f "$BTI" ] && BTILNK="$(curl -s https://api.github.com/repos/jc141x/BindToInterface/releases/latest)" && DLBTI="$(echo "$BTILNK" | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}')" && curl -L "$DLBTI" -o "$BTIARCH" && tar -xvf "$BTIARCH" -C "$JCD"

mount-dwarfs() { unmount-game &> /dev/null; [ -d "$GRT" ] && [ "$( ls -A "$GRT")" ] && echo "game is already mounted or extracted" && exit
mkdir -p {"$GMNT","$F/groot-rw","$F/groot-work","$GRT"} && dwarfs "$GAME" "$GMNT" && fuse-overlayfs -o lowerdir="$GMNT",upperdir="$F/groot-rw",workdir="$F/groot-work" "$GRT" && echo "mounted game"; }

mount-prefix() { unmount-prefix &> /dev/null; BASELNK="$(curl -s https://api.github.com/repos/jc141x/WINDEP/releases/latest)"; DLRLS="$(echo "$BASELNK" | awk -F '["]' '/"browser_download_url":/ && /tar.xz/ {print $4}')"
[ ! -f "$BASEARCH" ] && [ ! -d "$BASE" ] && curl -L "$DLRLS" -o "$BASEARCH" && [ ! -f "$BASEARCH" ] && echo "download failed, trying to download from torrent with aria2" && aria2c -d "$JCD" --seed-time=0 "magnet:?xt=urn:btih:A350F52826740B67A00075F0A1CADC0CDB356334&dn=base.tar.xz&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce" && [ ! -f "$JCD/$BASEARCH" ] && echo "download failed with aria2 as well" && exit

export WINEPREFIX="$JCD/prefix"; [ -f "$PRF" ] && find "$PRF" -mtime +7 -type f -delete
[ -f "$BASEARCH" ] && [ ! -f "$PRF" ] && tar -xvf "$BASEARCH" -C "$JCD" > /dev/null
[ -f "$BASEARCH" ] && [ ! -f "$PRF" ] && WINEPREFIX="$JCD/prefix" bash "$BASEINSTALL" && sleep 2 && mkdwarfs -l5 -i "$JCD/prefix" -o "$PRF" && rm -Rf "$WINEPREFIX" && rm -Rf "$BASE";

[ ! -d "$WINEPREFIX" ] && mkdir -p {"$PRFMT","$F/data/user-data","$F/data/work","$F/data/prefix-tmp"} && dwarfs "$PRF" "$PRFMT" -o cache_image && fuse-overlayfs -o lowerdir="$PRFMT",upperdir="$F/data/user-data",workdir="$F/data/work" "$F/data/prefix-tmp"; echo "mounted prefix"; }

unmount-dwarfs() { killall gamescope && fuser -k "$GMNT"; fusermount3 -u -z "$GRT"; fusermount3 -u -z "$GMNT" && rm -d -f "$GMNT" && rm -d -f "$F/groot-work"; echo "unmounted dwarfs"; }
unmount-prefix() { fuser -k "$PRFMT"; fusermount3 -u -z "$F/data/prefix-tmp" && rm -d -f "$F/data/prefix-tmp"; fusermount3 -u -z "$PRFMT" && rm -d -f "$PRFMT"; echo "unmounted prefix"; }
extract-dwarfs() { [ -d "$GRT" ] && [ "$( ls -A "$GRT")" ] && echo "game is already mounted or extracted" && exit; mkdir "$GRT"; dwarfsextract -i "$GAME" -o "$GRT"; }
extract-xz() { [ -d "$GRT" ] && [ "$( ls -A "$GRT")" ] && echo "game is already extracted" && exit; mkdir "$GRT"; tar -xvf "$F/groot.tar.xz" -C "$F"; }
delete-dwarfs-image() { rm -Rf "$GAME"; }
compress-game() { [ ! -f "$GAME" ] && mkdwarfs -l7 -B30 -i "$GRT" -o "$GAME"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; else exit; fi; done
