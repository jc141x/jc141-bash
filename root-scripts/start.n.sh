#!/bin/bash
# checks
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed." && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed." && exit; cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; STS="$PWD/settings.sh"; LOGO="$PWD/logo.txt.gz";
export JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ ! -d "$JCD" ] && mkdir -p "$JCD"

# dwarfs
bash "$STS" mount-dwarfs; zcat "$LOGO";

# auto-unmount
[ "${UNMOUNT:=1}" = "0" ] && echo "Game will not unmount automatically due to user input." || { function cleanup { cd "$OLDPWD" && bash "$STS" unmount-dwarfs; }; trap 'cleanup' EXIT INT SIGINT SIGTERM; echo "Game will unmount automatically once all child processes close. Can be disabled with UNMOUNT=0"; }

# block WAN
[ ! -f "/usr/lib64/bindToInterface.so" ] && echo "bindtointerface package not installed, no WAN blocking." && exit 0 || [ "${WANBLK:=1}" = "0" ] && echo "WAN blocking is not enabled due to user input." || { export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD='/usr/$LIB/bindToInterface.so'; echo "bindtointerface WAN blocking enabled."; }

# bwrap
[ ! -f "/usr/bin/bwrap" ] && echo "BWRAP package not installed, no filesystem isolation." && exit || [ "${BWRAP:=1}" = "0" ] && echo "BWRAP isolation is not enabled due to user input." || { export BWRP="bwrap --bind / / --dev-bind /dev /dev --bind "$HOME" "$JCD/universal-saves-and-configuration" --bind "$PWD/files/groot-rw" "$JCD/universal-saves-and-configuration""; echo "BWRAP isolation enabled." && echo "Path of universally isolated (BWRAP) saves and configurations is "$JCD/universal-saves-and-configuration""; }

# start
echo "For any misunderstandings or need of support, join the community on Matrix."
[ "${DBG:=0}" = "1" ] || { export WINEDEBUG='-all' && echo "Output muted by default to avoid performance impact. Can unmute with DBG=1." && exec &>/dev/null; }
cd "$PWD/files/groot"; ./"game.bin" "$@"
