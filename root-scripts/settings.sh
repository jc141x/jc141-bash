#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit

mount-dwarfs() { unmount-dwarfs &> /dev/null; [ -d "$PWD/files/groot" ] && [ "$( ls -A "$PWD/files/groot")" ] && echo "game is already mounted or extracted" && exit
mkdir -p {"$PWD/files/groot-mnt","$PWD/files/groot-rw","$PWD/files/groot-work","$PWD/files/groot"} && dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/groot-mnt" -o clone_fd -o cache_image && fuse-overlayfs -o lowerdir="$PWD/files/groot-mnt",upperdir="$PWD/files/groot-rw",workdir="$PWD/files/groot-work" "$PWD/files/groot" && echo "mounted game"; }
unmount-dwarfs() { fuser -k "$PWD/files/groot-mnt"; fusermount3 -u -z "$PWD/files/groot"; fusermount3 -u -z "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-work"; echo "unmounted dwarfs"; }
extract-dwarfs() { [ -d "$PWD/files/groot" ] && [ "$( ls -A "$PWD/files/groot")" ] && echo "game is already mounted or extracted" && exit; mkdir "$PWD/files/groot"; dwarfsextract -i "$PWD/files/groot.dwarfs" -o "$PWD/files/groot"; }
delete-dwarfs() { rm -Rf "$PWD/files/groot.dwarfs"; }
compress-to-dwarfs() { [ ! -f "$PWD/files/groot.dwarfs" ] && mkdwarfs -l7 -B30 -i "$PWD/files/groot" -o "$PWD/files/groot.dwarfs"; }
extract-xz() { [ -d "$PWD/files/groot" ] && [ "$( ls -A "$PWD/files/groot")" ] && echo "game is already extracted" && exit; mkdir "$PWD/files/groot"; tar -xvf "$PWD/files/groot.tar.xz" -C "$PWD/files"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; else exit; fi; done
