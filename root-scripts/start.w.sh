#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; export R="$PWD"; STS="$R/settings.sh"; WHA="$R/files/wha.sh"; LOGO="$PWD/files/logo.txt.gz"
[ ! -e "$WHA" ] && cp /opt/jc141-bash/wha.sh "$WHA"; [ ! -e "$LOGO" ] && cp /opt/jc141-bash/logo.txt.gz "$LOGO";

# wine settings
export WINE_LARGE_ADDRESS_AWARE=1; export WINEFSYNC=1; export WINEDLLOVERRIDES="mshtml=d;";

# image handling and muting output
bash "$STS" mount-dwarfs; bash "$STS" mount-prefix; zcat "$LOGO"; [ "${DBG:=0}" = "1" ] || exec &>/dev/null

# path defining
export WINEPREFIX="$PWD/files/data/prefix-tmp"; export BINDIR="$PWD/files/groot"; BIN="game.exe"

# wine handling
_WINE="wine-tkg"; bash "$WHA" "$_WINE"; [ -x "$BINDIR/wine/bin/wine" ] && export WINE="$BINDIR/wine/bin/wine" || export WINE="$(command -v wine)"; CMD=("$WINE" "$BIN");

# gamescope
: ${GAMESCOPE:=$(command -v gamescope)}; [ -x "$GAMESCOPE" ] && CMD=("$GAMESCOPE" -f -- "${CMD[@]}");

# exit trap for auto-unmount
function cleanup { cd "$OLDPWD" && bash "$STS" unmount-prefix && bash "$STS" unmount-dwarfs; }
trap 'cleanup' EXIT INT SIGINT SIGTERM

# block non-lan networking
export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD="/home/$USER/.local/share/jc141/bindToInterface.so"

# start
cd "$BINDIR"; "${CMD[@]}" "$@"
