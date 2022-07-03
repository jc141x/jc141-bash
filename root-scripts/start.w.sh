#!/bin/bash
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; export R="$PWD"; DWRFST="$R/dwarfsettings.sh"; RMT="$PWD/files/rumtricks.sh"; WHA="$PWD/files/wha.sh"; 
[ ! -e "$RMT" ] && cp /usr/bin/rumtricks "$RMT"; [ ! -e "$WHA" ] && cp /usr/bin/wha "$WHA"; export WINE_LARGE_ADDRESS_AWARE=1;
export WINEFSYNC=1; export WINEDLLOVERRIDES="mscoree=d;mshtml=d;"; 
export BINDIR="$PWD/files/groot"; BIN="game.exe";
export WINE="$(command -v wine)"; [ ! -x "$WINE" ] && export WINE="$BINDIR/wine/bin/wine"; CMD=("$WINE" "$BIN");

# gamescope/FSR
: ${GAMESCOPE:=$(command -v gamescope)}; [ -x "$GAMESCOPE" ] && CMD=("$GAMESCOPE" -f -- "${CMD[@]}");

# Custom WINE (wine-tkg, wine-ge, wine-tkg-nomingw)
CWINE="wine-tkg"; bash "$WHA" "$CWINE"

# dwarfs
bash "$DWRFST" mount-game; bash "$DWRFST" mount-prefix;
export WINEPREFIX="$PWD/files/data/prefix-tmp"

# Rumtricks
bash "$RMT" isolation

# Cleanup (runs when game exits/crashes)
function cleanup { cd "$OLDPWD" && bash "$DWRFST" unmount-prefix unmount-game; }
trap 'cleanup' EXIT SIGINT SIGTERM

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
            Pain⠀hweals,⠀chicks⠀dwig⠀scwas,⠀gwory⠀wasts⠀foweva!
                  jc141 - 1337x.to -⠀rumpowered.org
EOF
echo -e "\e[0m"
[ "${DBG:=0}" = "1" ] || exec &>/dev/null
cd "$BINDIR"; "${CMD[@]}" "$@"
