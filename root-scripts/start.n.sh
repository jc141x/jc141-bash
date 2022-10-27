#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; R="$PWD"; STS="$R/settings.sh"; LOGO="$PWD/files/logo.txt.gz"; [ ! -e "$LOGO" ] && cp /opt/jc141/bash/logo.txt.gz "$LOGO";
export JCDN="${XDG_DATA_HOME:-$HOME/.local/share}/jc141/native"; [ ! -d "$JCDN" ] && mkdir -p "$JCDN"

# image handling, muting output and exit trap for auto-unmount
bash "$STS" mount-dwarfs; zcat "$LOGO"; [ "${DBG:=0}" = "1" ] || exec &>/dev/null
function cleanup { cd "$OLDPWD" && bash "$STS" unmount-dwarfs; }
trap 'cleanup' EXIT INT SIGINT SIGTERM

# path defining
BINDIR="$R/files/groot"; BIN="game.bin";

# block non-lan networking
export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD="/usr/lib/bindToInterface.so"
export HOME="$JCDN"; export XDG_DATA_HOME="$JCDN/local"; export XDG_CONFIG_HOME="$JCDN/config"; mkdir -p {"$HOME","$XDG_CONFIG_HOME","$XDG_DATA_HOME"};

# start
cd "$BINDIR"; ./"$BIN" "$@"
