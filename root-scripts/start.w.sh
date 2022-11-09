#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; export R="$PWD"; STS="$R/settings.sh"; VLK="$R/files/vlk.sh"; LOGO="$PWD/files/logo.txt.gz"
[ ! -e "$LOGO" ] && cp /opt/jc141/bash/logo.txt.gz "$LOGO"; [ ! -e "$VLK" ] && cp /opt/jc141/bash/vlk.sh "$VLK"; export JCDW="${XDG_DATA_HOME:-$HOME/.local/share}/jc141/wine"; [ ! -d "$JCDW" ] && mkdir -p "$JCDW"
export DXVK_ENABLE_NVAPI=1; export WINE_LARGE_ADDRESS_AWARE=1

# dwarfs
bash "$STS" mount-dwarfs; zcat "$LOGO"; [ "${DBG:=0}" = "1" ] || exec &>/dev/null
function cleanup { cd "$OLDPWD" && bash "$STS" unmount-dwarfs; }
trap 'cleanup' EXIT INT SIGINT SIGTERM

# wine
export WINEPREFIX="$JCDW/prefix"; export WINE="$(command -v wine)"; export WINEDLLOVERRIDES="mshtml=d;nvapi,nvapi64=n"; if [ ! -x "$(command -v vlk-jc141)" ]; then bash "$VLK"; else vlk-jc141; fi

# block non-lan networking
export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD="/usr/lib/bindToInterface.so"

# start
cd "$R/files/groot"; "$WINE" "game.exe" "$@"
