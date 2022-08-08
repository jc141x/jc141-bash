#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
RMTDIR="${XDG_DATA_HOME:-$HOME/.local/share}/rumtricks"; [ ! -d "$RMTDIR" ] && mkdir -p "$RMTDIR"; RMTCONTENT="$RMTDIR/rumtricks-content"; RMTARCH="rumtricks-content.tar.lzma";
PRF="$RMTDIR/prefix.dwarfs"; RMT="$RMTDIR/rumtricks.sh";

mount-game() { unmount-game &> /dev/null;
[ -d "$PWD/files/groot" ] && echo -n "mounting path exists | " && [ "$( ls -A "$PWD/files/groot")" ] && echo -n "game is already mounted or extracted | " && exit
mkdir -p {"$PWD/files/groot-mnt","$PWD/files/groot-rw","$PWD/files/groot-work","$PWD/files/groot"} && dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/groot-mnt" && fuse-overlayfs -o lowerdir="$PWD/files/groot-mnt",upperdir="$PWD/files/groot-rw",workdir="$PWD/files/groot-work" "$PWD/files/groot" && echo -n "mounted game | "; }

mount-prefix() { unmount-prefix &> /dev/null;
# downloading
RMTRLS="$(curl -s https://api.github.com/repos/jc141x/rumtricks/releases/latest)"
DLRLS="$(echo "$RMTRLS" | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}')"
[ ! -f "$RMTDIR/$RMTARCH" ] && [ ! -d "$RMTCONTENT" ] && curl -L "$DLRLS" -o "$RMTDIR/$RMTARCH" && [ ! -f "$RMTDIR/$RMTARCH" ] && echo -n "download failed | " && exit || [ ! -d "$RMTCONTENT" ] && tar -xvf "$RMTDIR/$RMTARCH" -C "$RMTDIR" > /dev/null && rm -Rf "$RMTDIR/$RMTARCH"

# prefix generation
[ -f "$PRF" ] && find "$RMTDIR/prefix.dwarfs" -mtime +60 -type f -delete; export WINEPREFIX="$RMTDIR/prefix"; [ ! -f "$RMT" ] && cp "$PWD/files/rumtricks.sh" "$RMT";
[ ! -f "$PRF" ] && WINEPREFIX="$RMTDIR/prefix" bash "$RMT" isolation directx vcrun dxvk && sleep 2 && mkdwarfs -l7 -B5 -i "$RMTDIR/prefix" -o "$RMTDIR/prefix.dwarfs" && rm -Rf "$WINEPREFIX"

# mounting prefix
[ ! -d "$WINEPREFIX" ] && mkdir -p {"$RMTDIR/prefix-mnt","$PWD/files/data/user-data","$PWD/files/data/work","$PWD/files/data/prefix-tmp"} && dwarfs "$RMTDIR/prefix.dwarfs" "$RMTDIR/prefix-mnt" -o cache_image && fuse-overlayfs -o lowerdir="$RMTDIR/prefix-mnt",upperdir="$PWD/files/data/user-data",workdir="$PWD/files/data/work" "$PWD/files/data/prefix-tmp";
echo -n "mounted prefix | "; }

unmount-game() { wineserver -k && killall gamescope && fuser -k "$PWD/files/groot-mnt"
fusermount3 -u -z "$PWD/files/groot"
fusermount3 -u -z "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-work"
echo -n "unmounted game | "; }

unmount-prefix() { wineserver -k && fuser -k "$RMTDIR/prefix-mnt"
fusermount3 -u -z "$PWD/files/data/prefix-tmp" && rm -d -f "$PWD/files/data/prefix-tmp";
fusermount3 -u -z "$RMTDIR/prefix-mnt" && rm -d -f "$RMTDIR/prefix-mnt"
echo -n "unmounted prefix | "; }

extract-game() { [ -d "$PWD/files/groot" ] && echo -n "extraction path exists | " && [ "$( ls -A "$PWD/files/groot")" ] && echo -n "game is already mounted or extracted | " && exit
echo "extracting game, this may take a while"; tstart="$(date +%s)" && mkdir "$PWD/files/groot"; dwarfsextract -i "$PWD/files/groot.dwarfs" -o "$PWD/files/groot" && tend="$(date +%s)"; elapsed="$((tend - tstart))" && echo "done in $((elapsed / 60)) min and $((elapsed % 60)) sec"; }

delete-dwarfs-image() { rm -Rf "$PWD/files/groot.dwarfs" && echo "deleting dwarfs image"; }

compress-game() { [ ! -f "$PWD/files/groot.dwarfs" ] && mkdwarfs -l7 -B30 -i "$PWD/files/groot" -o "$PWD/files/groot.dwarfs"; }

mount-wine() { unmount-wine &> /dev/null; W="$1"; G="$2"; WHA="$RMTDIR/$W.dwarfs"; [ -f "$WHA" ] && find "$WHA" -mtime +30 -type f -delete; 
# checking wine
[ ! -f "$WHA" ] && [ -x "/bin/$W" ] && echo -n "detected $W on system. | " && exit || echo -n "$W not detected locally | "
[ ! -f "$WHA" ] && [ -x "$PWD/wine/bin/wine" ]  && echo -n "$W found on relative path. | " && exit || echo -n "$W not found on relative path | "

# downloading wine
[ ! -f "$WHA" ] && [ ! -f "$RMTDIR/$W.tar.lzma" ] && echo -n "$W.tar.lzma not found, downloading | " && URL="$(curl -s https://api.github.com/repos/jc141x/$G/releases | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}' | head -n 1)" && curl -L "$URL" -o "$RMTDIR/$W.tar.lzma"
[ ! -f "$WHA" ] && [ ! -f "$RMTDIR/$W.tar.lzma" ] && echo -n "download failed | " && exit || echo -n "$W.tar.lzma downloaded | "

# generating wine
[ ! -f "$WHA" ] && echo -n "extracting $W. | " && tar -xvf "$RMTDIR/$W.tar.lzma" > /dev/null && mkdwarfs -l7 -B30 -i "$PWD/wine" -o "$RMTDIR/$W.dwarfs" && rm -Rf "$PWD/wine" ;

# mounting wine
[ -d "$PWD/wine" ] && echo -n "mounting path exists | " && [ "$( ls -A "$PWD/wine")" ] && echo -n "wine is already mounted or extracted | " && exit
mkdir -p "$PWD/wine" && dwarfs "$WHA" "$PWD/wine" -o cache_image && echo -n "mounted wine | "; }

unmount-wine() { [ -x "$(command -v wineserver)" ] && wineserver -k && fuser -k "$PWD/wine"
fusermount3 -u -z "$PWD/wine" && rm -d -f "$PWD/wine"
echo -n "unmounted wine | "; }

wine-tkg() { mount-wine "wine-tkg" "wine-tkg-git";}

wine-ge() { mount-wine "wine-ge" "wine-ge-custom";}

wine-tkg-nomingw() { mount-wine "wine-tkg-nomingw" "wine-tkg-nomingw";}

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; else exit; fi; done
