#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ ! -d "$JCD" ] && mkdir -p "$JCD"; BASE="$JCD/base";
PRF="$JCD/prefix-v3.dwarfs"; GAME="$PWD/files/groot.dwarfs"; GRT="$PWD/files/groot"; PRFMT="$JCD/prefix-mnt"; GMNT="$PWD/files/groot-mnt";

mount-dwarfs() { unmount-game &> /dev/null; [ -d "$GRT" ] && [ "$( ls -A "$GRT")" ] && echo "game is already mounted or extracted" && exit
mkdir -p {"$GMNT","$PWD/files/groot-rw","$PWD/files/groot-work","$GRT"} && dwarfs "$GAME" "$GMNT" -o clone_fd -o cache_image && fuse-overlayfs -o lowerdir="$GMNT",upperdir="$PWD/files/groot-rw",workdir="$PWD/files/groot-work" "$GRT" && echo "mounted game"; }

mount-prefix() { unmount-prefix &> /dev/null; export WINEPREFIX="$JCD/prefix"; [ -f "$PRF" ] && find "$PRF" -mtime +7 -type f -delete
[ ! -f "$PRF" ] && export WINEPREFIX="$JCD/prefix" && wineboot -i && wine winecfg -v win10 && bash "$PWD/files/vlk.sh" dxvk && bash "$PWD/files/vlk.sh" vkd3d && sleep 10 && mkdwarfs -l6 -i "$JCD/prefix" -o "$PRF" && rm -Rf "$WINEPREFIX";
[ ! -d "$WINEPREFIX" ] && mkdir -p {"$PRFMT","$PWD/files/data/user-data","$PWD/files/data/work","$PWD/files/data/prefix-tmp"} && dwarfs "$PRF" "$PRFMT" -o clone_fd -o cache_image && fuse-overlayfs -o lowerdir="$PRFMT",upperdir="$PWD/files/data/user-data",workdir="$PWD/files/data/work" "$PWD/files/data/prefix-tmp"; echo "mounted prefix"; }

unmount-dwarfs() { killall gamescope && fuser -k "$GMNT"; fusermount3 -u -z "$GRT"; fusermount3 -u -z "$GMNT" && rm -d -f "$GMNT" && rm -d -f "$PWD/files/groot-work"; echo "unmounted dwarfs"; }
unmount-prefix() { fuser -k "$PRFMT"; fusermount3 -u -z "$PWD/files/data/prefix-tmp" && rm -d -f "$PWD/files/data/prefix-tmp"; fusermount3 -u -z "$PRFMT" && rm -d -f "$PRFMT"; echo "unmounted prefix"; }
extract-dwarfs() { fusermount3 -u "$GMNT" && [ -d "$GRT" ] && [ "$( ls -A "$GRT")" ] && echo "game is already mounted or extracted" && exit; echo "extracting game files, this can take a while" && mkdir "$GRT" & mkdir "$GMNT"; dwarfs "$GAME" "$GMNT" -o clone_fd && cp -r "$GMNT"/* "$GRT" && fusermount3 -u "$GMNT" && rm -Rf "$GMNT"; }
delete-dwarfs-image() { rm -Rf "$GAME"; }
compress-game() { [ ! -f "$GAME" ] && mkdwarfs -l7 -B30 -i "$GRT" -o "$GAME"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; else exit; fi; done
