#!/bin/bash
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit
export HOME="$PWD/files/data"; export XDG_DATA_HOME="$PWD/files/data/.local"; export XDG_CONFIG_HOME="$PWD/files/data/.config"; mkdir -p {"$HOME","$XDG_CONFIG_HOME","$XDG_DATA_HOME"};

GROOT="$PWD/files/groot"; BINDIR="$GROOT/gzdoom"; BIN="gzdoom"; echo "$BIN" >"$PWD/files/binval.txt";

# Internal WAD: https://zdoom.org/wiki/IWAD
IWAD="GAME/GAME.WAD"

# Patch WADs: https://zdoom.org/wiki/PWAD
PWADS=(
    "PWADs/MOD1/MOD1.wad" # MOD1
    "PWADs/MOD2.pk3" # MOD2
)

# launcher
CMD=("$BINDIR/$BIN" -iwad "$IWAD" -file "${PWADS[@]}");

# gamescope/FSR
: ${GAMESCOPE:=$(command -v gamescope)}; RRES=$(command -v rres); FSR_MODE="${FSR:=}";
[ -x "$GAMESCOPE" ] && { [[ -x "$RRES" && -n "$FSR_MODE" ]] && CMD=("$GAMESCOPE" -f $("$RRES" -g "$FSR_MODE") -- "${CMD[@]}") || CMD=("$GAMESCOPE" -f -- "${CMD[@]}"); };

# dwarfs
DFS="$PWD/dwarfsettings.sh"; [ ! -f "$BINDIR/$BIN" ] && "$DFS" mount

cleanup() { "$DFS" force-unmount; }

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

trap 'cleanup' EXIT SIGINT SIGTERM

[ "${DBG:=0}" = "1" ] || exec &>/dev/null
cd "$GROOT"; "${CMD[@]}" "$@"
