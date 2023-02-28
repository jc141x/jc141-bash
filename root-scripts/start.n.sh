#!/bin/bash
# checks
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed." && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed." && exit; cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; STS="$PWD/settings.sh"; LOGO="$PWD/logo.txt.gz";

# dwarfs
bash "$STS" mount-dwarfs; zcat "$LOGO";

# auto-unmount
function cleanup { cd "$OLDPWD" && bash "$STS" unmount-dwarfs; }; trap 'cleanup' EXIT INT SIGINT SIGTERM

# block WAN
[ "${WANBLK:=1}" = "0" ] && echo "WAN blocking is not enabled due to no bindtointerface package or user input." || { export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD='/usr/$LIB/bindToInterface.so'; [ -f "/usr/lib64/bindToInterface.so" ] && echo "WAN blocking is enabled."; }

# start
echo "For any misunderstandings or need of support, join the community on Matrix."
[ "${DBG:=0}" = "1" ] || { exec &>/dev/null; echo "Output muted by default for avoiding performance impact. Unmute with DBG=1."; }
cd "$PWD/files/groot"; ./"game.bin" "$@"
