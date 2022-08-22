#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; export R="$PWD"; DWRF="$R/dwarfsettings.sh"; WHA="$R/files/wha.sh"; VLK="$R/files/vulkan.sh"; LOGO="$PWD/files/logo.txt" 
[ ! -e "$WHA" ] && cp /opt/jc141-bash/wha.sh "$WHA"; [ ! -e "$VLK" ] && cp /opt/jc141-bash/vulkan.sh "$VLK"; [ ! -e "$LOGO" ] && cp /opt/jc141-bash/logo.txt "$LOGO";
export WINE_LARGE_ADDRESS_AWARE=1; export WINEFSYNC=1; export WINEDLLOVERRIDES="mshtml=d;";

bash "$DWRF" mount-game; bash "$DWRF" mount-prefix

export WINEPREFIX="$PWD/files/data/prefix-tmp"; export BINDIR="$PWD/files/groot"; BIN="game.exe"

_WINE="wine-tkg"; bash "$WHA" "$_WINE"; [ -x "$BINDIR/wine/bin/wine" ] && export WINE="$BINDIR/wine/bin/wine" || export WINE="$(command -v wine)"; CMD=("$WINE" "$BIN");
bash "$VLK" dxvk

: ${GAMESCOPE:=$(command -v gamescope)}; [ -x "$GAMESCOPE" ] && CMD=("$GAMESCOPE" -f -- "${CMD[@]}");

function cleanup { cd "$OLDPWD" && bash "$DWRF" unmount-prefix unmount-game; }
trap 'cleanup' EXIT INT SIGINT SIGTERM

[ "${DBG:=0}" = "1" ] || exec &>/dev/null
export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD="/home/$USER/.local/share/jc141/bindToInterface.so"

zcat "$PWD/files/logo.txt.gz"; cd "$BINDIR"; "${CMD[@]}" "$@"
