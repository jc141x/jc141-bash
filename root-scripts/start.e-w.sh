#!/bin/bash
# checks
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed." && exit; [ ! -x "$(command -v bwrap)" ] && echo "bubblewrap not installed." && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed." && exit; cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; export JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ ! -d "$JCD/wine" ] && mkdir -p "$JCD/wine"

# wine
export WINE="$(command -v wine)";
export WINEPREFIX="$JCD/wine/prefix"; export WINEDLLOVERRIDES="winemenubuilder.exe=d;mshtml=d;nvapi,nvapi64=n"; export WINE_LARGE_ADDRESS_AWARE=1; export RESTORE_RESOLUTION=1;

# dwarfs
bash "$PWD/settings.sh" mount; zcat "$PWD/logo.txt.gz"; echo "Path of the wineprefix is: $WINEPREFIX";

# auto-unmount
[ "${UNMOUNT:=1}" = "0" ] && echo "Game will not unmount automatically due to user input." || { function cleanup { cd "$OLDPWD" && bash "$PWD/settings.sh" unmount; }; trap 'cleanup' EXIT INT SIGINT SIGTERM; echo "Game will unmount automatically when closed. Can be disabled with UNMOUNT=0."; }

# external vulkan translation
# export DXVK_ASYNC=1

ping -c 1 github.com >/dev/null || { echo "Possibly no network. This may mean that booting will fail." ; }; VLKLOG="$WINEPREFIX/vulkan.log"; VULKAN="$PWD/vulkan"
VLKVER="$(curl -s -m 5 https://api.github.com/repos/jc141x/vulkan/releases/latest | awk -F '["/]' '/"browser_download_url":/ {print $11}' | cut -c 1-)"
status-vulkan() { [[ ! -f "$VLKLOG" || -z "$(awk "/^${FUNCNAME[1]}\$/ {print \$1}" "$VLKLOG" 2>/dev/null)" ]] || { echo "${FUNCNAME[1]} present" && return 1; }; }
vulkan() { DL_URL="$(curl -s https://api.github.com/repos/jc141x/vulkan/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"; VLK="$(basename "$DL_URL")"
[ ! -f "$VLK" ] && command -v curl >/dev/null 2>&1 && curl -LO "$DL_URL" && tar -xvf "vulkan.tar.xz" || { rm "$VLK" && echo "ERROR: Failed to extract vulkan translation." && return 1; }
rm -rf "vulkan.tar.xz" && bash "$PWD/vulkan/setup-vulkan.sh" && rm -Rf "$VULKAN"; }
vulkan-dl() { echo "Using external vulkan translation (dxvk,vkd3d,dxvk-nvapi)." && vulkan && echo "$VLKVER" >"$VLKLOG"; }
[[ ! -f "$VLKLOG" && -z "$(status-vulkan)" ]] && vulkan-dl;
[[ -f "$VLKLOG" && -n "$VLKVER" && "$VLKVER" != "$(awk '{print $1}' "$VLKLOG")" ]] && { rm -f vulkan.tar.xz || true; } && vulkan-dl; export DXVK_ENABLE_NVAPI=1

# block WAN
[ ! -f "/usr/lib64/bindToInterface.so" ] && echo "bindtointerface package not installed, no WAN blocking." || [ "${WANBLK:=1}" = "0" ] && echo "WAN blocking is not enabled due to user input." || { export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD='/usr/$LIB/bindToInterface.so'; echo "bindtointerface WAN blocking enabled."; }

# start
echo "For any misunderstandings or need of support, join the community on Matrix.";
[ "${DBG:=0}" = "1" ] || { export WINEDEBUG='-all' && echo "Output muted by default to avoid performance impact. Can unmute with DBG=1." && exec &>/dev/null; }
cd "$PWD/files/groot"; bwrap --ro-bind / / --dev-bind /dev /dev --tmpfs tmp/ --bind "$JCD"/wine ~/.local/share/jc141/wine --bind "$(pwd)/" "$(pwd)/" "$WINE" "game.exe" "$@"
