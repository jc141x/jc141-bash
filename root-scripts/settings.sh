#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ ! -d "$JCD" ] && mkdir -p "$JCD"; F="$PWD/files"; BASE="$JCD/base";
PRF="$JCD/prefix-v3.dwarfs"; GAME="$F/groot.dwarfs"; GRT="$F/groot"; PRFMT="$JCD/prefix-mnt"; GMNT="$F/groot-mnt";

mount-dwarfs() { unmount-game &> /dev/null; [ -d "$GRT" ] && [ "$( ls -A "$GRT")" ] && echo "game is already mounted or extracted" && exit
mkdir -p {"$GMNT","$F/groot-rw","$F/groot-work","$GRT"} && dwarfs "$GAME" "$GMNT" && fuse-overlayfs -o lowerdir="$GMNT",upperdir="$F/groot-rw",workdir="$F/groot-work" "$GRT" && echo "mounted game"; }

mount-prefix() { unmount-prefix &> /dev/null; export WINEPREFIX="$JCD/prefix"; [ -f "$PRF" ] && find "$PRF" -mtime +7 -type f -delete
[ ! -f "$PRF" ] && export WINEPREFIX="$JCD/prefix" && wineboot -i && wine winecfg -v win10 && bash "$PWD/files/vlk.sh" dxvk && bash "$PWD/files/vlk.sh" vkd3d && sleep 10 && mkdwarfs -l6 -i "$JCD/prefix" -o "$PRF" && rm -Rf "$WINEPREFIX";
[ ! -d "$WINEPREFIX" ] && mkdir -p {"$PRFMT","$F/data/user-data","$F/data/work","$F/data/prefix-tmp"} && dwarfs "$PRF" "$PRFMT" -o cache_image && fuse-overlayfs -o lowerdir="$PRFMT",upperdir="$F/data/user-data",workdir="$F/data/work" "$F/data/prefix-tmp"; echo "mounted prefix"; }

unmount-dwarfs() { killall gamescope && fuser -k "$GMNT"; fusermount3 -u -z "$GRT"; fusermount3 -u -z "$GMNT" && rm -d -f "$GMNT" && rm -d -f "$F/groot-work"; echo "unmounted dwarfs"; }
unmount-prefix() { fuser -k "$PRFMT"; fusermount3 -u -z "$F/data/prefix-tmp" && rm -d -f "$F/data/prefix-tmp"; fusermount3 -u -z "$PRFMT" && rm -d -f "$PRFMT"; echo "unmounted prefix"; }
extract-dwarfs() { [ -d "$GRT" ] && [ "$( ls -A "$GRT")" ] && echo "game is already mounted or extracted" && exit; mkdir "$GRT"; dwarfsextract -i "$GAME" -o "$GRT"; }
delete-dwarfs-image() { rm -Rf "$GAME"; }
compress-game() { [ ! -f "$GAME" ] && mkdwarfs -l7 -B30 -i "$GRT" -o "$GAME"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; else exit; fi; done
