#!/bin/bash
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; F="$PWD/files"; 
export HOME="$F/data"; export XDG_DATA_HOME="$F/data/.local"; export XDG_CONFIG_HOME="$F/data/.config"; [ ! -d "$F/data" ] && cp -r "$F/data-backup" "$F/data"; mkdir -p {"$HOME","$XDG_CONFIG_HOME","$XDG_DATA_HOME"};
LOGO="$PWD/files/logo.txt.gz"; [ ! -e "$LOGO" ] && cp /opt/jc141-bash/logo.txt.gz "$LOGO";
YUZU="$(command -v yuzu)"; BINDIR="$F/groot"; BIN="game.nsp"; CMD=("$YUZU" "$BIN");

[ "${DBG:=0}" = "1" ] || exec &>/dev/null
BIND_INTERFACE=lo; LD_PRELOAD="/home/$USER/.local/share/jc141/bindToInterface.so"

zcat "$LOGO; cd "$BINDIR"; exec "${CMD[@]}" "$@"
