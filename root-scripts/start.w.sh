#!/bin/bash
cd "$(dirname "$0")" || exit; [ "$EUID" = "0" ] && exit; R="$PWD"; F="$PWD/files"; RMT="$F/rumtricks.sh"; WHA="$F/wha.sh"; [ ! -e "$RMT" ] && cp /usr/bin/rumtricks "$RMT"; [ ! -e "$WHA" ] && cp /usr/bin/wha "$WHA"; export WINEPREFIX="$F/prefix"; export WINE_LARGE_ADDRESS_AWARE=1;

export WINEFSYNC=1; export WINEDLLOVERRIDES="mscoree=d;mshtml=d;"; export BINDIR="$F/groot"; BIN="game.exe";
[ -x "/bin/wine-tkg" ] && export WINE="$(command -v wine)" || export WINE="$BINDIR/wine/bin/wine"; CMD=("$WINE" "$BIN")

# gamescope/FSR
: ${GAMESCOPE:=$(command -v gamescope)}; RRES=$(command -v rres); FSR_MODE="${FSR:=}"; [ -x "$GAMESCOPE" ] && { [[ -x "$RRES" && -n "$FSR_MODE" ]] && CMD=("$GAMESCOPE" -f $("$RRES" -g "$FSR_MODE") -- "${CMD[@]}") || CMD=("$GAMESCOPE" -f -- "${CMD[@]}"); }

# dwarfs
[ ! -f "$BINDIR/$BIN" ] && mkdir -p {"$F/groot-mnt","$F/groot-rw","$F/groot-work","$F/groot"} && dwarfs "$F/groot.dwarfs" "$F/groot-mnt" -o cache_image && fuse-overlayfs -o lowerdir="$F/groot-mnt",upperdir="$F/groot-rw",workdir="$F/groot-work" "$F/groot"
function cleanup {
cd "$R" && wineserver -k && fuser -k "$F/groot-mnt"
[ -d "$F/groot" ] && sleep 3 && fusermount -u "$F/groot";
[ -d "$F/groot-mnt" ] && sleep 3 && fusermount -u "$F/groot-mnt" && rm -d -f "$F/groot-mnt"; }
trap 'cleanup' EXIT SIGINT SIGTERM

bash "$WHA" wine-tkg; bash "$RMT" isolation

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
