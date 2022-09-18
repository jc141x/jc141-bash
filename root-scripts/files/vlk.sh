#!/bin/bash
cd "$(dirname "$(readlink -f "$0")")" || exit
ping -c 3 github.com >/dev/null || { echo "Github could not be reached, probably no network." ; exit; }
VLKLOG="$JCDW/vulkan.log"; VULKAN="$PWD/vulkan"

status-vulkan() { [[ ! -f "$VLKLOG" || -z "$(awk "/^${FUNCNAME[1]}\$/ {print \$1}" "$VLKLOG" 2>/dev/null)" ]] || { echo "${FUNCNAME[1]} present" && return 1; }; }

vulkan() { DL_URL="$(curl -s https://api.github.com/repos/jc141x/vulkan/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"; VLK="$(basename "$DL_URL")"
[ ! -f "$VLK" ] && command -v curl >/dev/null 2>&1 && curl -LO "$DL_URL" && tar -xvf "vulkan.tar.xz" || { rm "$VLK" && echo "ERROR: failed to extract vulkan translation" && return 1; }
rm -rf "vulkan.tar.xz" && wineboot -i && bash "$PWD/vulkan/setup-vulkan.sh" && wineserver -w && rm -Rf "$VULKAN"; }

vulkan-dl() { echo "using vulkan translation from github" && vulkan && echo "$VLKVER" >"$VLKLOG"; }

VLKVER="$(curl -s -m 5 https://api.github.com/repos/jc141x/vulkan/releases/latest | awk -F '["/]' '/"browser_download_url":/ {print $11}' | cut -c 1-)"

[[ ! -f "$VLKLOG" && -z "$(status-vulkan)" ]] && vulkan-dl;

[[ -f "$VLKLOG" && -n "$VLKVER" && "$VLKVER" != "$(awk '{print $1}' "$VLKLOG")" ]] && { rm -f vulkan.tar.xz || true; } && echo "updating vulkan translation" && vulkan-dl && echo "vulkan translation is up-to-date"
