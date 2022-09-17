#!/bin/bash
ping -c 3 github.com >/dev/null || { echo "Github could not be reached, probably no network." ; exit; }
export WINETKGLOG="$JCDW/wine-tkg.log"; WINETKG="$JCDW/wine-tkg"; [ ! -d "$WINETKG" ] && mkdir -p "$WINETKG"
export WINEGELOG="$JCDW/wine-ge.log"; WINEGE="$JCDW/wine-ge"; [ ! -d "$WINEGE" ] && mkdir -p "$WINEGE"

status-tkg() { [[ ! -f "$WINETKGLOG" || -z "$(awk "/^${FUNCNAME[1]}\$/ {print \$1}" "$WINETKGLOG" 2>/dev/null)" ]] || { echo "${FUNCNAME[1]} present" && return 1; }; }
status-ge() { [[ ! -f "$WINEGELOG" || -z "$(awk "/^${FUNCNAME[1]}\$/ {print \$1}" "$WINEGELOG" 2>/dev/null)" ]] || { echo "${FUNCNAME[1]} present" && return 1; }; }
download() { command -v curl >/dev/null 2>&1 && curl -LO "$1"; }

github-wine-tkg() { DL_URL="$(curl -s https://api.github.com/repos/jc141x/wine-tkg-git/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"; TKG="$(basename "$DL_URL")"
[ ! -f "$TKG" ] && download "$DL_URL" && tar -xvf "wine-tkg.tar.xz" -C "$WINETKG" || { rm "$TKG" && echo "ERROR: failed to extract wine-tkg" && return 1; }
rm -rf "wine-tkg.tar.xz"; }
github-wine-ge() { DL_URL="$(curl -s https://api.github.com/repos/jc141x/wine-ge-custom/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"; GE="$(basename "$DL_URL")"
[ ! -f "$GE" ] && download "$DL_URL" && tar -xvf "wine-ge.tar.xz" -C "$WINEGE" || { rm "$GE" && echo "ERROR: failed to extract wine-ge" && return 1; }
rm -rf "wine-ge.tar.xz"; }

wine-tkg-dl() { echo "using wine-tkg from github" && github-wine-tkg && echo "$TKGVER" >"$WINETKGLOG"; }
wine-ge-dl() { echo "using wine-ge from github" && github-wine-ge && echo "$GEVER" >"$WINEGELOG"; }

wine-tkg() { TKGVER="$(curl -s -m 5 https://api.github.com/repos/jc141x/wine-tkg-git/releases/latest | awk -F '["/]' '/"browser_download_url":/ {print $11}' | cut -c 1-)"
[[ ! -f "$WINETKGLOG" && -z "$(status-tkg)" ]] && wine-tkg-dl; [[ -f "$WINETKGLOG" && -n "$TKGVER" && "$TKGVER" != "$(awk '{print $1}' "$WINETKGLOG")" ]] && { rm -f wine-tkg.tar.xz || true; } && echo "updating wine-tkg" && rm -Rf "$WINETKG" && mkdir -p "$WINETKG" && wine-tkg-dl && echo "wine-tkg is up-to-date"; }
wine-ge() { GEVER="$(curl -s -m 5 https://api.github.com/repos/jc141x/wine-ge-custom/releases/latest | awk -F '["/]' '/"browser_download_url":/ {print $11}' | cut -c 1-)"
[[ ! -f "$WINEGELOG" && -z "$(status-ge)" ]] && wine-ge-dl; [[ -f "$WINEGELOG" && -n "$TKGVER" && "$TKGVER" != "$(awk '{print $1}' "$WINEGELOG")" ]] && { rm -f wine-ge.tar.xz || true; } && echo "updating wine-ge" && rm -Rf "$WINEGE" && mkdir -p "$WINEGE" && wine-ge-dl && echo "wine-ge is up-to-date"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; else exit; fi; done
