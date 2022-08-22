#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; R="$PWD"; DWRF="$R/dwarfsettings.sh"; LOGO="$PWD/files/logo.txt.gz"; [ ! -e "$LOGO" ] && cp /opt/jc141-bash/logo.txt.gz "$LOGO";

BINDIR="$R/files/groot"; BIN="game.bin"; CMD=(./"$BIN")

: ${GAMESCOPE:=$(command -v gamescope)}; [ -x "$GAMESCOPE" ] && CMD=("$GAMESCOPE" -f -- "${CMD[@]}");

bash "$DWRF" mount-game
function cleanup { cd "$OLDPWD" && bash "$DWRF" unmount-game; }
trap 'cleanup' EXIT INT SIGINT SIGTERM

[ "${DBG:=0}" = "1" ] || exec &>/dev/null
export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD="/home/$USER/.local/share/jc141/bindToInterface.so"
export HOME="$R/files/data"; export XDG_DATA_HOME="$R/files/data/.local"; export XDG_CONFIG_HOME="$R/files/data/.config"; mkdir -p {"$HOME","$XDG_CONFIG_HOME","$XDG_DATA_HOME"};

zcat "$LOGO"; cd "$BINDIR"; "${CMD[@]}" "$@"
