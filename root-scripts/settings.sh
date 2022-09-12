#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ ! -d "$JCD" ] && mkdir -p "$JCD";

mount-dwarfs() { unmount-game &> /dev/null; [ -d "$PWD/files/groot" ] && [ "$( ls -A "$PWD/files/groot")" ] && echo "game is already mounted or extracted" && exit
mkdir -p {"$PWD/files/groot-mnt","$PWD/files/groot-rw","$PWD/files/groot-work","$PWD/files/groot"} && dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/groot-mnt" -o clone_fd -o cache_image && fuse-overlayfs -o lowerdir="$PWD/files/groot-mnt",upperdir="$PWD/files/groot-rw",workdir="$PWD/files/groot-work" "$PWD/files/groot" && echo "mounted game"; }

mount-prefix() { unmount-prefix &> /dev/null; export WINEPREFIX="$JCD/prefix"; [ -f "$JCD/revised-prefix.dwarfs" ] && find "$JCD/revised-prefix.dwarfs" -mtime +7 -type f -delete
[ ! -f "$JCD/revised-prefix.dwarfs" ] && export WINEPREFIX="$JCD/prefix" && wineboot -i && sleep 10 && wine winecfg -v win10 && bash "$PWD/files/vlk.sh" && sleep 10 && mkdwarfs -l6 -i "$JCD/prefix" -o "$JCD/revised-prefix.dwarfs" && rm -Rf "$WINEPREFIX";
[ ! -d "$WINEPREFIX" ] && mkdir -p {"$JCD/prefix-mnt","$PWD/files/data/user-data","$PWD/files/data/work","$PWD/files/data/prefix-tmp"} && dwarfs "$JCD/revised-prefix.dwarfs" "$JCD/prefix-mnt" -o clone_fd -o cache_image && fuse-overlayfs -o lowerdir="$JCD/prefix-mnt",upperdir="$PWD/files/data/user-data",workdir="$PWD/files/data/work" "$PWD/files/data/prefix-tmp"; echo "mounted prefix"; }

unmount-dwarfs() { killall gamescope && fuser -k "$PWD/files/groot-mnt"; fusermount3 -u -z "$PWD/files/groot"; fusermount3 -u -z "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-work"; echo "unmounted dwarfs"; }
unmount-prefix() { fuser -k "$JCD/prefix-mnt"; fusermount3 -u -z "$PWD/files/data/prefix-tmp" && rm -d -f "$PWD/files/data/prefix-tmp"; fusermount3 -u -z "$JCD/prefix-mnt" && rm -d -f "$JCD/prefix-mnt"; echo "unmounted prefix"; }
extract-dwarfs() { fusermount3 -u "$PWD/files/groot-mnt" && [ -d "$PWD/files/groot" ] && [ "$( ls -A "$PWD/files/groot")" ] && echo "game is already mounted or extracted" && exit; echo "extracting game files, this can take a while" && mkdir "$PWD/files/groot" & mkdir "$PWD/files/groot-mnt"; dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/groot-mnt" -o clone_fd && cp -r "$PWD/files/groot-mnt"/* "$PWD/files/groot" && fusermount3 -u "$PWD/files/groot-mnt" && rm -Rf "$PWD/files/groot-mnt"; }
delete-dwarfs-image() { rm -Rf "$PWD/files/groot.dwarfs"; }
compress-game() { [ ! -f "$PWD/files/groot.dwarfs" ] && mkdwarfs -l7 -B30 -i "$PWD/files/groot" -o "$PWD/files/groot.dwarfs"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; else exit; fi; done
