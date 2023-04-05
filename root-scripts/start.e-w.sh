#!/bin/bash
# checks
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed." && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed." && exit; cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; STS="$PWD/settings.sh"; LOGO="$PWD/logo.txt.gz";
export JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ ! -d "$JCD/wine" ] && mkdir -p "$JCD/wine"; GAMENAME=$(basename "$(cd "$(dirname "$0")" && pwd)" | sed 's/-jc141$//'); [! -d "$JCD/saves/$GAMENAME" ] && mkdir -p "$JCD/saves/$GAMENAME"

# wine
export WINE="$(command -v wine)";
export WINEPREFIX="$JCD/wine/prefix"; export WINEDLLOVERRIDES="mshtml=d;nvapi,nvapi64=n"; export WINE_LARGE_ADDRESS_AWARE=1;

# dwarfs
bash "$STS" mount-dwarfs; zcat "$LOGO"; echo "Path of the wineprefix is: $WINEPREFIX";

# auto-unmount
[ "${UNMOUNT:=1}" = "0" ] && echo "Game will not unmount automatically due to user input." || { function cleanup { cd "$OLDPWD" && bash "$STS" unmount-dwarfs; }; trap 'cleanup' EXIT INT SIGINT SIGTERM; echo "Game will unmount automatically once all child processes close. Can be disabled with UNMOUNT=0."; }

# external vulkan translation
if [ ! -x "$(command -v vlk-jc141)" ];
  then { ping -c 3 github.com >/dev/null || { echo "Github could not be reached via ping command, possibly no network. This may mean that the necessary requisites will be missing if this is the first run." ; }; VLKLOG="$WINEPREFIX/vulkan.log"; VULKAN="$PWD/vulkan"
    status-vulkan() { [[ ! -f "$VLKLOG" || -z "$(awk "/^${FUNCNAME[1]}\$/ {print \$1}" "$VLKLOG" 2>/dev/null)" ]] || { echo "${FUNCNAME[1]} present" && return 1; }; }
    vulkan() { DL_URL="$(curl -s https://api.github.com/repos/jc141x/vulkan/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"; VLK="$(basename "$DL_URL")"
    [ ! -f "$VLK" ] && command -v curl >/dev/null 2>&1 && curl -LO "$DL_URL" && tar -xvf "vulkan.tar.xz" || { rm "$VLK" && echo "ERROR: Failed to extract vulkan translation." && return 1; }
    rm -rf "vulkan.tar.xz" && wineboot -i && bash "$PWD/vulkan/setup-vulkan.sh" && wineserver -w && rm -Rf "$VULKAN"; }
    vulkan-dl() { echo "Using external vulkan translation (dxvk,vkd3d,dxvk-nvapi) from github." && vulkan && echo "$VLKVER" >"$VLKLOG"; }
    VLKVER="$(curl -s -m 5 https://api.github.com/repos/jc141x/vulkan/releases/latest | awk -F '["/]' '/"browser_download_url":/ {print $11}' | cut -c 1-)"
    [[ ! -f "$VLKLOG" && -z "$(status-vulkan)" ]] && vulkan-dl;
    [[ -f "$VLKLOG" && -n "$VLKVER" && "$VLKVER" != "$(awk '{print $1}' "$VLKLOG")" ]] && { rm -f vulkan.tar.xz || true; } && echo "Updating external vulkan translation. (dxvk,vkd3d,dxvk-nvapi)" && vulkan-dl && echo "External vulkan translation is up-to-date."; }
else vlk-jc141; fi; export DXVK_ENABLE_NVAPI=1

# block WAN
[ ! -f "/usr/lib64/bindToInterface.so" ] && echo "bindtointerface package not installed, no WAN blocking." || [ "${WANBLK:=1}" = "0" ] && echo "WAN blocking is not enabled due to user input." || { export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD='/usr/$LIB/bindToInterface.so'; echo "bindtointerface WAN blocking enabled."; }

# bubblewrap isolation
function box_prefix { bwrap --unshare-user --ro-bind / / --bind "$WINEPREFIX/drive_c/users/$USER" "$JCD/saves/$GAMENAME" --dev-bind /dev /dev --bind "$WINEPREFIX" "$WINEPREFIX" --bind "$PWD" "$PWD" --bind /tmp /tmp "$@"; }

# start
echo "For any misunderstandings or need of support, join the community on Matrix.";
[ "${DBG:=0}" = "1" ] || { export WINEDEBUG='-all' && echo "Output muted by default to avoid performance impact. Can unmute with DBG=1." && exec &>/dev/null; }

cd "$PWD/files/groot"; EXE="game.exe"

[ ! -f "/usr/bin/bwrap" ] || [ "${BWRAP:=1}" = "0" ] && "$WINE" "$EXE" "$@" || box_prefix "$WINE" "$EXE" "$@"
