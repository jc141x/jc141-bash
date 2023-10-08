#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs is not installed." && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs is not installed." && exit
HWRAMTOTAL="$(grep MemTotal /proc/meminfo | awk '{print $2}')"; [ "$HWRAMTOTAL" -gt 24000000 ] && CACHEPERCENT=30 || CACHEPERCENT=15; CACHEONRAM=$((HWRAMTOTAL * CACHEPERCENT / 100)); CORUID="$(id -u $USER)"; CORGID="$(id -g $USER)"
declare -A BLOCK_LEVELS=(['L0']='-B18 -S18' ['L1']='-B20 -S20' ['L2']='-B22 -S22' ['L3']='-B24 -S24' ['L4']='-B26 -S26'); [ -n "$BLOCK" ] && BLOCK_FLAGS=(${BLOCK_LEVELS[$BLOCK]})
mount() { unmount &> /dev/null; [ -d "$PWD/files/groot" ] && [ "$( ls -A "$PWD/files/groot")" ] && echo "Game is already mounted or extracted." && exit; mkdir -p {"$PWD/files/.groot-mnt","$PWD/files/overlay-storage","$PWD/files/.groot-work","$PWD/files/groot"} && dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/.groot-mnt" -o cachesize="$CACHEONRAM"k -o clone_fd -o cache_image && fuse-overlayfs -o squash_to_uid="$CORUID" -o squash_to_gid="$CORGID" -o lowerdir="$PWD/files/.groot-mnt",upperdir="$PWD/files/overlay-storage",workdir="$PWD/files/.groot-work" "$PWD/files/groot" && echo "Mounted game. Extraction not required. "bash settings.sh extract" will make script use extracted files instead."; }
unmount() { fuser -k "$PWD/files/.groot-mnt" 2> /dev/null; fusermount3 -u -z "$PWD/files/groot"; fusermount3 -u -z "$PWD/files/.groot-mnt"; echo "Unmounted game."; }
extract() { [ -d "$PWD/files/groot" ] && [ "$( ls -A "$PWD/files/groot")" ] && echo "Game is already mounted or extracted." && exit; mkdir "$PWD/files/groot"; echo "Started extraction process." && dwarfsextract --stdout-progress -i "$PWD/files/groot.dwarfs" -o "$PWD/files/groot"; }
delete-image() { rm -Rf "$PWD/files/groot.dwarfs"; }
compress() { [ ! -f "$PWD/files/groot.dwarfs" ] && mkdwarfs -l7 "${BLOCK_FLAGS[@]}" --no-create-timestamp --order=nilsimsa:255:40000:40000 -i "$PWD/files/groot" -o "$PWD/files/groot.dwarfs" && echo "${BLOCK_FLAGS[@]}" > "$PWD/files/block-lvl.txt"; }

for i in "$@"; do if type "$i" &> /dev/null; then "$i"; else exit; fi; done
