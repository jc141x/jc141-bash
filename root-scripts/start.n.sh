#!/bin/bash
# checks
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed." && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed." && exit; cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; 

# define
STS="$PWD/settings.sh"; LOGO="$PWD/logo.txt.gz"; export JCDN="${XDG_DATA_HOME:-$HOME/.local/share}/jc141/native"; [ ! -d "$JCDN" ] && mkdir -p "$JCDN"; export HOME="$JCDN"; export XDG_DATA_HOME="$JCDN/local"; export XDG_CONFIG_HOME="$JCDN/config"; mkdir -p {"$HOME","$XDG_CONFIG_HOME","$XDG_DATA_HOME"};

# dwarfs
bash "$STS" mount-dwarfs; zcat "$LOGO"; echo "The path for game saves is: $JCDN (Some games choose to ignore saving in this path)"; echo "For any misunderstandings or need of support, join the community on Matrix."

# auto-unmount
function cleanup { cd "$OLDPWD" && bash "$STS" unmount-dwarfs; }; trap 'cleanup' EXIT INT SIGINT SIGTERM

# block WAN
export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD='/usr/$LIB/bindToInterface.so'; [ -f "/usr/lib64/bindToInterface.so" ] && echo "WAN blocking is enabled." || echo "WAN blocking is not enabled due to no bindtointerface package."

# start
[ "${DBG:=0}" = "1" ] || { exec &>/dev/null; echo "Output muted by default for avoiding performance impact. Unmute with DBG=1."; }
cd "$PWD/files/groot"; ./"game.bin" "$@"
