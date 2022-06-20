#!/bin/bash
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; F="$PWD/files"; export HOME="$F/data"; export XDG_DATA_HOME="$F/data/.local"; export XDG_CONFIG_HOME="$F/data/.config"; mkdir -p {"$HOME","$XDG_CONFIG_HOME","$XDG_DATA_HOME"};

YUZU="$(command -v yuzu)"; export QT_QPA_PLATFORM=xcb
BINDIR="$F/groot"; BIN="game.nsp"; CMD=("$YUZU" "$BIN");

# copy backup data to real path
[ ! -d "$F/data" ] && cd "$F" && cp -r "data-backup" "data"

echo -e "\e[38;5;$((RANDOM%257))m" && cat << 'EOF'
       ⠀⠀⠀     ⠀ ⣴⣶⣤⡤⠦⣤⣀⣤⠆⠀⠀⠀⠀⠀⣈⣭⣿⣶⣿⣦⣼⣆
       ⠀⠀   ⠀ ⠀  ⠀⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦
       ⠀⠀⠀⠀⠀ ⠀  ⠀⠀⠀   ⠀⠀⠈⢿⣿⣟⠦⠀⣾⣿⣿⣷⠀⠀⠀⠀⠻⠿⢿⣿⣧⣄
       ⠀⠀⠀⠀ ⠀  ⠀⠀   ⠀⠀⠀⠀⠀⣸⣿⣿⢧⠀⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄
       ⠀⠀⠀ ⠀  ⠀   ⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⠈⠀⠀⠀⠀⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀
       ⠀⠀⠀ ⠀     ⢠⣧⣶⣥⡤⢄⠀⣸⣿⣿⠘⠀⠀⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄
       ⠀⠀    ⠀  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷⠀⠀⠀⢊⣿⣿⡏⠀⠀⢸⣿⣿⡇⠀⢀⣠⣄⣾⠄
          ⠀⠀   ⣠⣿⠿⠛⠀⢀⣿⣿⣷⠘⢿⣿⣦⡀⠀⢸⢿⣿⣿⣄⠀⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄
          ⠀   ⠀⠙⠃⠀⠀⠀⣼⣿⡟⠀⠀⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿⠀⣿⣿⡇⠀⠛⠻⢷⣄
          ⠀ ⠀  ⠀⠀⠀⠀⠀⢻⣿⣿⣄⠀⠀⠀⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟⠀⠫⢿⣿⡆
           ⠀  ⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃
          Pain⠀heals,⠀chicks⠀dig⠀scars,⠀glory⠀lasts⠀forever!
                jc141 - 1337x.to -⠀rumpowered.org
EOF
echo -e "\e[0m"

[ "${DBG:=0}" = "1" ] || exec &>/dev/null
cd "$BINDIR"; exec "${CMD[@]}" "$@"
