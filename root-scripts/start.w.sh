#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; export R="$PWD"; DWRF="$R/dwarfsettings.sh"; RMT="$PWD/files/rumtricks.sh"; WHA="$PWD/files/wha.sh";
[ ! -e "$RMT" ] && cp /usr/bin/rumtricks "$RMT"; [ ! -e "$WHA" ] && cp /usr/bin/wha "$WHA"; export WINE_LARGE_ADDRESS_AWARE=1; export WINEFSYNC=1; export WINEDLLOVERRIDES="mshtml=d;";

# prefix + game files
export WINEPREFIX="$PWD/files/data/prefix-tmp"; export BINDIR="$PWD/files/groot"; BIN="game.exe"

# WINE handler (choices: wine-tkg, wine-ge, wine-tkg-nomingw)
_WINE="wine-tkg"; bash "$DWRF" "$_WINE"; [ -x "$PWD/wine/bin/wine" ] && export PATH="$PWD/wine/bin:$PATH"; export WINE="$(command -v wine)"; CMD=("$WINE" "$BIN");

# dwarfs
bash "$DWRF" mount-game; bash "$DWRF" mount-prefix

# gamescope
: ${GAMESCOPE:=$(command -v gamescope)}; [ -x "$GAMESCOPE" ] && CMD=("$GAMESCOPE" -f -- "${CMD[@]}");

# rumtricks
bash "$RMT" dxvk

# Cleanup (runs when game exits/crashes)
function cleanup { cd "$OLDPWD" && bash "$DWRF" unmount-prefix unmount-game unmount-wine; }
trap 'cleanup' EXIT INT SIGINT SIGTERM

echo -e "\e[38;5;$((RANDOM%257))m" && cat << 'EOF'
                     ⣐⢕⢕⢕⢕⢕⢕⢕⢕⠅⢗⢕⢕⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕
                    ⢐⢕⢕⢕⢕⢕⣕⢕⢕⠕⠁⢕⢕⢕⢕⢕⢕⢕⢕⠅⡄⢕⢕⢕⢕⢕⢕⢕⢕⢕
                    ⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕
                    ⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕
                    ⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑
                    ⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐
                    ⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐
                    ⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔
                    ⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕
                    ⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕
                    ⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕
                    ⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕
                    ⣆⢕⠄⢱⣄⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⢕⢕⠕⢁
                    ⣿⣦⡀⣿⣿⣷⣶⣬⣍⣛⣛⣛⡛⠿⠿⠿⠛⠛⢛⣛⣉⣭⣤⣂⢜⠕⢑⣡⣴⣿
            Pain⠀hweals,⠀chicks⠀dwig⠀scwas,⠀gwory⠀lasts⠀foweva!
                  jc141 - 1337x.to -⠀rumpowered.org
EOF
echo -e "\e[0m"
[ "${DBG:=0}" = "1" ] || exec &>/dev/null
cd "$BINDIR"; "${CMD[@]}" "$@"
