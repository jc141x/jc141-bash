#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs is not installed." && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs is not installed." && exit

mount-dwarfs() { unmount-dwarfs &> /dev/null; [ -d "$PWD/files/groot" ] && [ "$( ls -A "$PWD/files/groot")" ] && echo "Game is already mounted or extracted." && exit
mkdir -p {"$PWD/files/groot-mnt","$PWD/files/groot-rw","$PWD/files/groot-work","$PWD/files/groot"} && dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/groot-mnt" -o clone_fd -o cache_image && fuse-overlayfs -o lowerdir="$PWD/files/groot-mnt",upperdir="$PWD/files/groot-rw",workdir="$PWD/files/groot-work" "$PWD/files/groot" && echo "Mounted game. Extraction not required."; }
unmount-dwarfs() { fuser -k "$PWD/files/groot-mnt"; fusermount3 -u -z "$PWD/files/groot"; fusermount3 -u -z "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-work"; echo "Unmounted game."; }
extract-dwarfs() { [ -d "$PWD/files/groot" ] && [ "$( ls -A "$PWD/files/groot")" ] && echo "Game is already mounted or extracted." && exit; mkdir "$PWD/files/groot"; echo "Started extraction process. Only done at first run. The game will not run mounted due to the unlikelyness of running smoothly based on our judgment. If the process is closed before the extraction finishes, then the script will try to run the incomplete files. Have patience or delete files/groot directory and run again if the process was canceled." && dwarfsextract -i "$PWD/files/groot.dwarfs" -o "$PWD/files/groot"; }
delete-dwarfs() { rm -Rf "$PWD/files/groot.dwarfs"; }
compress-to-dwarfs() { [ ! -f "$PWD/files/groot.dwarfs" ] && mkdwarfs -l7 -i "$PWD/files/groot" -o "$PWD/files/groot.dwarfs"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; else exit; fi; done
