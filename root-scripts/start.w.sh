#!/bin/bash
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; export R="$PWD"; DWRF="$R/dwarfsettings.sh"; WHA="$R/files/wha.sh";
[ ! -e "$WHA" ] && cp /usr/bin/wha "$WHA"; export WINE_LARGE_ADDRESS_AWARE=1; export WINEFSYNC=1; export WINEDLLOVERRIDES="mshtml=d;";

bash "$DWRF" mount-game; bash "$DWRF" mount-prefix

export WINEPREFIX="$PWD/files/data/prefix-tmp"; export BINDIR="$PWD/files/groot"; BIN="game.exe"

_WINE="wine-tkg"; bash "$WHA" "$_WINE"; [ -x "$BINDIR/wine/bin/wine" ] && export WINE="$BINDIR/wine/bin/wine" || export WINE="$(command -v wine)"; CMD=("$WINE" "$BIN");
bash "$PWD/files/vulkan.sh" dxvk

function cleanup { cd "$OLDPWD" && bash "$DWRF" unmount-prefix unmount-game; }
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
