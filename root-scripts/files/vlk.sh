#!/bin/bash
[ "$EUID" = "0" ] && exit; cd "$(dirname "$(realpath "$0")")" || exit 1

extract() { tar -xvf "$1" &>/dev/null; }; applied() { echo -n "${FUNCNAME[1]} applied"; }
download() { command -v curl >/dev/null 2>&1 && curl -LO "$1"; }

github_dxvk() { DL_URL="$(curl -s https://api.github.com/repos/jc141x/dxvk/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"; DXVK="$(basename "$DL_URL")"
[ ! -f "$DXVK" ] && download "$DL_URL"; extract "$DXVK" || { rm "$DXVK" && echo "failed to extract dxvk" && return 1; }
cd "${DXVK//.tar.gz/}" || exit; ./setup_dxvk.sh install && wineserver -w; cd "$OLDPWD" || exit; rm -rf "${DXVK//.tar.gz/}"; }

dxvk() { DXVKVER="$(curl -s -m 5 https://api.github.com/repos/jc141x/dxvk/releases/latest | awk -F '["/]' '/"browser_download_url":/ {print $11}' | cut -c 2-)"; SYSDXVK="$(command -v setup_dxvk)"
dxvk() { [ -n "$SYSDXVK" ] && echo "using local dxvk" && "$SYSDXVK" install && wineserver -w && applied && [ -z "$SYSDXVK" ] && echo "using external dxvk" && github_dxvk; }
dxvk; }

github_vkd3d() { DL_URL="$(curl -s https://api.github.com/repos/jc141x/vkd3d-proton/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"
VKD3D="$(basename "$DL_URL")"; [ ! -f "$VKD3D" ] && download "$DL_URL"; extract "$VKD3D" || { rm "$VKD3D" && echo "failed to extract vkd3d" && return 1; }
cd "${VKD3D//.tar.zst/}" || exit; ./setup_vkd3d_proton.sh install && wineserver -w
cd "$OLDPWD" || exit; rm -rf "${VKD3D//.tar.zst/}"; }

vkd3d() { VKD3DVER="$(curl -s -m 5 https://api.github.com/jc141x/vkd3d-proton/releases/latest | awk -F '["/]' '/"browser_download_url":/ {print $11}' | cut -c 2-)"; SYSVKD3D="$(command -v setup_vkd3d_proton)"
vkd3d() { [ -n "$SYSVKD3D" ] && echo "using local vkd3d." && "$SYSVKD3D" install && wineserver -w && applied && [ -z "$SYSVKD3D" ] && echo "using external vkd3d" && github_vkd3d; }
vkd3d; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; else exit; fi; done
