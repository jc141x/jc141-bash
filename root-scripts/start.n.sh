#!/bin/bash
cd "$(dirname "$0")" || exit; [ "$EUID" = "0" ] && exit; R="$PWD"; DWRFST="$R/dwarfsettings.sh"; export HOME="$F/data"; export XDG_DATA_HOME="$F/data/.local"; export XDG_CONFIG_HOME="$F/data/.config"; mkdir -p {"$HOME","$XDG_CONFIG_HOME","$XDG_DATA_HOME"}

BINDIR="$PWD/files/groot"; BIN="game.bin"; CMD=(./"$BIN")

# gamescope/FSR
: ${GAMESCOPE:=$(command -v gamescope)}; RRES=$(command -v rres); FSR_MODE="${FSR:=}"; [ -x "$GAMESCOPE" ] && { [[ -x "$RRES" && -n "$FSR_MODE" ]] && CMD=("$GAMESCOPE" -f $("$RRES" -g "$FSR_MODE") -- "${CMD[@]}") || CMD=("$GAMESCOPE" -f -- "${CMD[@]}"); }

# dwarfs
bash "$DWRFST" mount-game
function cleanup {
cd "$OLDPWD" && bash "$DWRFST" unmount-game
}
trap 'cleanup' EXIT SIGINT SIGTERM

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
cd "$BINDIR"; "${CMD[@]}" "$@"
