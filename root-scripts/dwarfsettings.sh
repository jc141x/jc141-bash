#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ -d "$JCD" ] && mkdir -p "$JCD"; BASE="$JCD/base"; BASEARCH="base.tar.lzma";
PRF="$JCD/prefix.dwarfs"; BASEINSTALL="$JCD/base/install.sh";
BTI="$JCD/bindToInterface.so"; BTIARCH="bindToInterface.tar.lzma"; [ ! -f "$BTI" ] && BTILNK="$(curl -s https://api.github.com/repos/jc141x/BindToInterface/releases/latest)" && DLBTI="$(echo "$BTILNK" | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}')" && curl -L "$DLBTI" -o "$JCD/$BTIARCH" && tar -xvf "$JCD/$BTIARCH" -C "$JCD" && [ ! -f "$BTI" ] && aria2c -d "$JCD" --seed-time=0 "magnet:?xt=urn:btih:B4A7E30D153FD5B44856AE95EF015496F1D114C8&dn=bindToInterface.tar.lzma&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=http%3A%2F%2Ftracker.dler.org%3A6969%2Fannounce" && tar -xvf "$JCD/$BTIARCH" -C "$JCD" && rm -Rf "$JCD/$BTIARCH"

mount-game() { unmount-game &> /dev/null;
[ -d "$PWD/files/groot" ] && echo -n "mounting path exists | " && [ "$( ls -A "$PWD/files/groot")" ] && echo -n "game is already mounted or extracted | " && exit
mkdir -p {"$PWD/files/groot-mnt","$PWD/files/groot-rw","$PWD/files/groot-work","$PWD/files/groot"} && dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/groot-mnt" && fuse-overlayfs -o lowerdir="$PWD/files/groot-mnt",upperdir="$PWD/files/groot-rw",workdir="$PWD/files/groot-work" "$PWD/files/groot" && echo -n "mounted game | "; }

mount-prefix() { unmount-prefix &> /dev/null;
# downloading
BASELNK="$(curl -s https://api.github.com/repos/jc141x/WINDEP/releases/latest)"
DLRLS="$(echo "$BASELNK" | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}')"
[ ! -f "$JCD/$BASEARCH" ] && [ ! -d "$BASE" ] && curl -L "$DLRLS" -o "$JCD/$BASEARCH" && [ ! -f "$JCD/$BASEARCH" ] && echo -n "download failed, trying to download from torrent with aria2" && aria2c -d "$JCD" --seed-time=0 "magnet:?xt=urn:btih:57C47B6A554BF5887850C28060F0AFE50924E5C8&dn=base.tar.lzma&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=http%3A%2F%2Ftracker.dler.org%3A6969%2Fannounce" && [ ! -f "$JCD/$BASEARCH" ] && echo -n "download failed with aria2 as well" && exit

# prefix generation
export WINEPREFIX="$JCD/prefix"
[ -f "$PRF" ] && find "$PRF" -mtime +60 -type f -delete
[ -f "$JCD/$BASEARCH" ] && [ ! -f "$PRF" ] && tar -xvf "$JCD/$BASEARCH" -C "$JCD" > /dev/null
[ -f "$JCD/$BASEARCH" ] && [ ! -f "$PRF" ] && WINEPREFIX="$JCD/prefix" bash "$BASEINSTALL" && sleep 2 && mkdwarfs -l7 -B5 -i "$JCD/prefix" -o "$JCD/prefix.dwarfs" && rm -Rf "$WINEPREFIX" && rm -Rf "$BASE";

# mounting prefix
[ ! -d "$WINEPREFIX" ] && mkdir -p {"$JCD/prefix-mnt","$PWD/files/data/user-data","$PWD/files/data/work","$PWD/files/data/prefix-tmp"} && dwarfs "$JCD/prefix.dwarfs" "$JCD/prefix-mnt" -o cache_image && fuse-overlayfs -o lowerdir="$JCD/prefix-mnt",upperdir="$PWD/files/data/user-data",workdir="$PWD/files/data/work" "$PWD/files/data/prefix-tmp";
echo -n "mounted prefix | "; }

unmount-game() { wineserver -k && killall gamescope && fuser -k "$PWD/files/groot-mnt"
fusermount3 -u -z "$PWD/files/groot"
fusermount3 -u -z "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-work"
echo -n "unmounted game | "; }

unmount-prefix() { wineserver -k && fuser -k "$JCD/prefix-mnt"
fusermount3 -u -z "$PWD/files/data/prefix-tmp" && rm -d -f "$PWD/files/data/prefix-tmp";
fusermount3 -u -z "$JCD/prefix-mnt" && rm -d -f "$JCD/prefix-mnt"
echo -n "unmounted prefix | "; }

extract-game() { [ -d "$PWD/files/groot" ] && echo -n "extraction path exists | " && [ "$( ls -A "$PWD/files/groot")" ] && echo -n "game is already mounted or extracted | " && exit
echo "extracting game, this may take a while"; tstart="$(date +%s)" && mkdir "$PWD/files/groot"; dwarfsextract -i "$PWD/files/groot.dwarfs" -o "$PWD/files/groot" && tend="$(date +%s)"; elapsed="$((tend - tstart))" && echo "done in $((elapsed / 60)) min and $((elapsed % 60)) sec"; }

delete-dwarfs-image() { rm -Rf "$PWD/files/groot.dwarfs" && echo "deleting dwarfs image"; }

compress-game() { [ ! -f "$PWD/files/groot.dwarfs" ] && mkdwarfs -l7 -B30 -i "$PWD/files/groot" -o "$PWD/files/groot.dwarfs"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; else exit; fi; done
