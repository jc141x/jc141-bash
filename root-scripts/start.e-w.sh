#!/bin/bash
# checks
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit; cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit;

# define
STS="$PWD/settings.sh"; LOGO="$PWD/logo.txt.gz"; export JCDW="${XDG_DATA_HOME:-$HOME/.local/share}/jc141/wine"; [ ! -d "$JCDW" ] && mkdir -p "$JCDW"

# wine
export WINE="$(command -v wine)"; export WINEPREFIX="$JCDW/prefix"; export WINEDLLOVERRIDES="mshtml=d;nvapi,nvapi64=n"; export WINE_LARGE_ADDRESS_AWARE=1;

# dwarfs
bash "$STS" mount-dwarfs; zcat "$LOGO"; [ "${DBG:=0}" = "1" ] || { export WINEDEBUG='-all' && exec &>/dev/null; }

# auto-unmount
function cleanup { cd "$OLDPWD" && bash "$STS" unmount-dwarfs; }; trap 'cleanup' EXIT INT SIGINT SIGTERM

# external vulkan translation
if [ ! -x "$(command -v vlk-jc141)" ];
   then { ping -c 3 github.com >/dev/null || { echo "Github could not be reached, probably no network." ; exit; }; VLKLOG="$WINEPREFIX/vulkan.log"; VULKAN="$PWD/vulkan"
          status-vulkan() { [[ ! -f "$VLKLOG" || -z "$(awk "/^${FUNCNAME[1]}\$/ {print \$1}" "$VLKLOG" 2>/dev/null)" ]] || { echo "${FUNCNAME[1]} present" && return 1; }; }
          vulkan() { DL_URL="$(curl -s https://api.github.com/repos/jc141x/vulkan/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"; VLK="$(basename "$DL_URL")"
          [ ! -f "$VLK" ] && command -v curl >/dev/null 2>&1 && curl -LO "$DL_URL" && tar -xvf "vulkan.tar.xz" || { rm "$VLK" && echo "ERROR: failed to extract vulkan translation" && return 1; }
          rm -rf "vulkan.tar.xz" && wineboot -i && bash "$PWD/vulkan/setup-vulkan.sh" && wineserver -w && rm -Rf "$VULKAN"; }
          vulkan-dl() { echo "using vulkan translation from github" && vulkan && echo "$VLKVER" >"$VLKLOG"; }
          VLKVER="$(curl -s -m 5 https://api.github.com/repos/jc141x/vulkan/releases/latest | awk -F '["/]' '/"browser_download_url":/ {print $11}' | cut -c 1-)"
          [[ ! -f "$VLKLOG" && -z "$(status-vulkan)" ]] && vulkan-dl;
          [[ -f "$VLKLOG" && -n "$VLKVER" && "$VLKVER" != "$(awk '{print $1}' "$VLKLOG")" ]] && { rm -f vulkan.tar.xz || true; } && echo "updating external vulkan translation" && vulkan-dl && echo "external vulkan translation is up-to-date"; }
else vlk-jc141; fi; export DXVK_ENABLE_NVAPI=1

# block non-lan networking
export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD='/usr/$LIB/bindToInterface.so';

# start
cd "$PWD/files/groot"; "$WINE" "game.exe" "$@"
