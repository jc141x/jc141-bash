#!/bin/bash
[ "$EUID" = "0" ] && exit; cd "$(dirname "$(realpath "$0")")" || exit 1
export VLKLOG="$WINEPREFIX/vlk.log";

extract() { tar -xvf "$1" &>/dev/null; }; applied() { echo "${FUNCNAME[1]}" >>"$VLKLOG"; echo -n "${FUNCNAME[1]} applied"; }
status() { [[ ! -f "$VLKLOG" || -z "$(awk "/^${FUNCNAME[1]}\$/ {print \$1}" "$VLKLOG" 2>/dev/null)" ]] || { echo -n "${FUNCNAME[1]} present" && return 1; }; }
download() { command -v curl >/dev/null 2>&1 && curl -LO "$1"; }

github_dxvk() { DL_URL="$(curl -s https://api.github.com/repos/jc141x/dxvk/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"; DXVK="$(basename "$DL_URL")"
[ ! -f "$DXVK" ] && download "$DL_URL"; extract "$DXVK" || { rm "$DXVK" && echo "ERROR: failed to extract dxvk" && return 1; }
cd "${DXVK//.tar.gz/}" || exit; ./setup_dxvk.sh install > /dev/null && wineserver -w; cd "$OLDPWD" || exit; rm -rf "${DXVK//.tar.gz/}"; }

dxvk() { DXVKVER="$(curl -s -m 5 https://api.github.com/repos/jc141x/dxvk/releases/latest | awk -F '["/]' '/"browser_download_url":/ {print $11}' | cut -c 2-)"; SYSDXVK="$(command -v setup_dxvk)"
    dxvk() {
    [ -n "$SYSDXVK" ] && echo "using dxvk from system" && "$SYSDXVK" install --symlink > /dev/null && wineserver -w && applied
    [ -z "$SYSDXVK" ] && echo "using dxvk from github" && github_dxvk && echo "$DXVKVER" >"$WINEPREFIX/.dxvk"; }
    [[ ! -f "$WINEPREFIX/.dxvk" && -z "$(status)" ]] && dxvk
    [[ -f "$WINEPREFIX/.dxvk" && -n "$DXVKVER" && "$DXVKVER" != "$(awk '{print $1}' "$WINEPREFIX/.dxvk")" ]] && { rm -f dxvk-*.tar.gz || true; } && echo -n "updating dxvk" && dxvk
echo -n "dxvk up-to-date"; }

github_vkd3d() { DL_URL="$(curl -s https://api.github.com/repos/jc141x/vkd3d-proton/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"
VKD3D="$(basename "$DL_URL")"; [ ! -f "$VKD3D" ] && download "$DL_URL"; extract "$VKD3D" || { rm "$VKD3D" && echo "failed to extract vkd3d" && return 1; }
cd "${VKD3D//.tar.zst/}" || exit; ./setup_vkd3d_proton.sh install > /dev/null && wineserver -w
cd "$OLDPWD" || exit; rm -rf "${VKD3D//.tar.zst/}"; }

vkd3d() { VKD3DVER="$(curl -s -m 5 https://api.github.com/jc141x/vkd3d-proton/releases/latest | awk -F '["/]' '/"browser_download_url":/ {print $11}' | cut -c 2-)"
    SYSVKD3D="$(command -v setup_vkd3d_proton)"
    vkd3d() {
        [ -n "$SYSVKD3D" ] && echo "using vkd3d from system" && "$SYSVKD3D" install --symlink > /dev/null && wineserver -w && applied
        [ -z "$SYSVKD3D" ] && echo "using vkd3d from github" && github_vkd3d && echo "$VKD3DVER" >"$WINEPREFIX/.vkd3d"; }
[[ ! -f "$WINEPREFIX/.vkd3d" && -z "$(status)" ]] && vkd3d
[[ -f "$WINEPREFIX/.vkd3d" && -n "$VKD3DVER" && "$VKD3DVER" != "$(awk '{print $1}' "$WINEPREFIX/.vkd3d")" ]] && { rm -f vkd3d-proton-*.tar.zst || true; } && echo "updating vkd3d" && vkd3d
echo -n "vkd3d up-to-date"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; else exit; fi; done
