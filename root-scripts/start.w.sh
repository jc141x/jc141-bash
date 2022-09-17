#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; export R="$PWD"; STS="$R/settings.sh"; WHA="$R/files/wha.sh"; VLK="$R/files/vlk.sh"; LOGO="$PWD/files/logo.txt.gz"
[ ! -e "$WHA" ] && cp /opt/jc141-bash/wha.sh "$WHA"; [ ! -e "$LOGO" ] && cp /opt/jc141-bash/logo.txt.gz "$LOGO"; [ ! -e "$VLK" ] && cp /opt/jc141-bash/vlk.sh "$VLK"
export JCDW="${XDG_DATA_HOME:-$HOME/.local/share}/jc141/wine"; [ ! -d "$JCDW" ] && mkdir -p "$JCDW"

# wine settings
export WINE_LARGE_ADDRESS_AWARE=1; export WINEFSYNC=1; export WINEDLLOVERRIDES="mshtml=d;";

# image handling and muting output
bash "$STS" mount-dwarfs; zcat "$LOGO"; [ "${DBG:=0}" = "1" ] || exec &>/dev/null

# path defining
export WINEPREFIX="$JCDW/prefix"; export BINDIR="$PWD/files/groot"; BIN="game.exe"

# wine handling
[ ! -x "$(command -v wine-tkg)" ] && export WINE="$JCDW/wine-tkg/wine/bin/wine" && bash "$WHA" wine-tkg || export WINE="$(command -v wine)"; CMD=("$WINE" "$BIN");
bash "$VLK" dxvk && bash "$VLK" vkd3d

# gamescope
: ${GAMESCOPE:=$(command -v gamescope)}; [ -x "$GAMESCOPE" ] && CMD=("$GAMESCOPE" -f -- "${CMD[@]}");

# exit trap for auto-unmount
function cleanup { cd "$OLDPWD" && bash "$STS" unmount-dwarfs; }
trap 'cleanup' EXIT INT SIGINT SIGTERM

# block non-lan networking
export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD="/usr/lib/bindToInterface.so"

# start
cd "$BINDIR"; "${CMD[@]}" "$@"
