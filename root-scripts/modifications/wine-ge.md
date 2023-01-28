Remove
```sh
# wine
export WINE="$(command -v wine)"
```

And add
```sh
# wine-ge
export WINE="$JCDW/wine-ge/wine/bin/wine" && { ping -c 3 github.com >/dev/null || { echo "Github could not be reached, probably no network or ping command was blocked. The game may or may not fail to run if wine-ge was never downloaded before." ; }
       export WINEGELOG="$JCDW/wine-ge.log"; WINEGE="$JCDW/wine-ge"; [ ! -d "$WINEGE" ] && mkdir -p "$WINEGE"
       status-ge() { [[ ! -f "$WINEGELOG" || -z "$(awk "/^${FUNCNAME[1]}\$/ {print \$1}" "$WINEGELOG" 2>/dev/null)" ]] || { echo "${FUNCNAME[1]} present" && return 1; }; }
       download() { command -v curl >/dev/null 2>&1 && curl -LO "$1"; }
       github-wine-ge() { DL_URL="$(curl -s https://api.github.com/repos/jc141x/wine-ge-custom/releases/latest | awk -F '["]' '/"browser_download_url":/ {print $4}')"; GE="$(basename "$DL_URL")"
       [ ! -f "$GE" ] && download "$DL_URL" && tar -xvf "wine-ge.tar.xz" -C "$WINEGE" || { rm "$GE" && echo "ERROR: failed to extract wine-ge." && return 1; }
       rm -rf "wine-ge.tar.xz"; }
       wine-ge-dl() { echo "Using wine-ge from github." && github-wine-ge && echo "$GEVER" >"$WINEGELOG"; }
       GEVER="$(curl -s -m 5 https://api.github.com/repos/jc141x/wine-ge-custom/releases/latest | awk -F '["/]' '/"browser_download_url":/ {print $11}' | cut -c 1-)"
[[ ! -f "$WINEGELOG" && -z "$(status-ge)" ]] && wine-ge-dl; [[ -f "$WINEGELOG" && -n "$TKGVER" && "$TKGVER" != "$(awk '{print $1}' "$WINEGELOG")" ]] && { rm -f wine-ge.tar.xz || true; } && echo "Updating wine-ge." && rm -Rf "$WINEGE" && mkdir -p "$WINEGE" && wine-ge-dl && echo "wine-ge is up-to-date."; }
```
