#!/bin/bash
cd "$(dirname "$0")" || exit; [ "$EUID" = "0" ] && exit
export HOME="$PWD/files/data"; export XDG_DATA_HOME="$PWD/files/data/.local"; export XDG_CONFIG_HOME="$PWD/files/data/.config"; mkdir -p {"$HOME","$XDG_CONFIG_HOME","$XDG_DATA_HOME"}

ROOTDIR="$PWD"; BINDIR="$PWD/files/groot"; BIN="game.bin"; echo "$BIN" >"$PWD/files/binval.txt"; CMD=(./"$BIN")

# gamescope/FSR
: ${GAMESCOPE:=$(command -v gamescope)}; RRES=$(command -v rres); FSR_MODE="${FSR:=}"
[ -x "$GAMESCOPE" ] && { [[ -x "$RRES" && -n "$FSR_MODE" ]] && CMD=("$GAMESCOPE" -f $("$RRES" -g "$FSR_MODE") -- "${CMD[@]}") || CMD=("$GAMESCOPE" -f -- "${CMD[@]}"); }

# dwarfs
[ ! -f "$BINDIR/$BIN" ] && mkdir -p {"$PWD/files/groot-mnt","$PWD/files/groot-rw","$PWD/files/groot-work","$PWD/files/groot"} && dwarfs "$PWD/files/groot.dwarfs" "$PWD/files/groot-mnt" -o cache_image && fuse-overlayfs -o lowerdir="$PWD/files/groot-mnt",upperdir="$PWD/files/groot-rw",workdir="$PWD/files/groot-work" "$PWD/files/groot"
function cleanup {
    cd "$ROOTDIR" && killall $(<"$PWD/files/binval.txt") && killall gamescope && sleep 2;
    [ -d "$PWD/files/groot" ] && fusermount -u "$PWD/files/groot";
    [ -d "$PWD/files/groot-mnt" ] && fusermount -u "$PWD/files/groot-mnt" && rm -d -f "$PWD/files/groot-mnt"
}
echo -e "\e[38;5;$((RANDOM%257))m" && cat << 'EOF'
       ⠀⠀⠀  ⠀ ⣴⣶⣤⡤⠦⣤⣀⣤⠆⠀⠀⠀⠀⠀⣈⣭⣿⣶⣿⣦⣼⣆
       ⠀⠀⠀ ⠀  ⠀⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦
       ⠀⠀⠀⠀⠀ ⠀  ⠀⠀⠀⠀⠀⠈⢿⣿⣟⠦⠀⣾⣿⣿⣷⠀⠀⠀⠀⠻⠿⢿⣿⣧⣄
       ⠀⠀⠀⠀ ⠀  ⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⢧⠀⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄
       ⠀⠀⠀ ⠀  ⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⠈⠀⠀⠀⠀⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀
       ⠀⠀⠀ ⠀  ⢠⣧⣶⣥⡤⢄⠀⣸⣿⣿⠘⠀⠀⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄
       ⠀⠀ ⠀  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷⠀⠀⠀⢊⣿⣿⡏⠀⠀⢸⣿⣿⡇⠀⢀⣠⣄⣾⠄
       ⠀⠀   ⣠⣿⠿⠛⠀⢀⣿⣿⣷⠘⢿⣿⣦⡀⠀⢸⢿⣿⣿⣄⠀⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄
       ⠀   ⠀⠙⠃⠀⠀⠀⣼⣿⡟⠀⠀⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿⠀⣿⣿⡇⠀⠛⠻⢷⣄
       ⠀ ⠀  ⠀⠀⠀⠀⠀⢻⣿⣿⣄⠀⠀⠀⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟⠀⠫⢿⣿⡆
        ⠀  ⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃
       Pain⠀heals,⠀chicks⠀dig⠀scars,⠀glory⠀lasts⠀forever!
             JC141 - 1337x.to -⠀rumpowered.org
EOF
echo -e "\e[0m"
trap 'cleanup' EXIT SIGINT SIGTERM
[ "${DBG:=0}" = "1" ] || exec &>/dev/null
cd "$BINDIR"; "${CMD[@]}" "$@"