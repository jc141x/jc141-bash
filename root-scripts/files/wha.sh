#!/bin/bash
wine-tkg() { [ -x "/bin/wine-tkg" ] && echo "detected wine-tkg on system" && exit || echo "wine-tkg not detected locally"
[ -x "$BINDIR/wine/bin/wine" ]  && echo "wine-tkg found on relative path" && exit || echo "wine-tkg not found on relative path"
[ ! -f "$PWD/wine-tkg.tar.xz" ] && echo "wine-tkg.tar.xz not found, downloading" && URL="$(curl -s https://api.github.com/repos/jc141x/wine-tkg-git/releases | awk -F '["]' '/"browser_download_url":/ && /tar.xz/ {print $4}' | head -n 1)" && curl -L "$URL" -o "wine-tkg.tar.xz"
[ ! -f "$PWD/wine-tkg.tar.xz" ] && echo "download failed" && exit || echo "wine-tkg.tar.xz downloaded"
echo "extracting wine-tkg" && tar -xvf "$PWD/wine-tkg.tar.xz" > /dev/null && mv "wine" "$BINDIR/wine"; }

wine-ge() { [ -x "/bin/wine-ge" ] && echo "detected wine-ge on system" && exit || echo "wine-ge not detected locally"
[ -x "$BINDIR/wine/bin/wine" ]  && echo "wine-ge found on relative path" && exit || echo "wine-ge not found on relative path"
[ ! -f "$PWD/wine-ge.tar.xz" ] && echo "wine-ge.tar.xz not found, downloading" && URL="$(curl -s https://api.github.com/repos/jc141x/wine-ge-custom/releases | awk -F '["]' '/"browser_download_url":/ && /tar.xz/ {print $4}' | head -n 1)" && curl -L "$URL" -o "wine-ge.tar.xz"
[ ! -f "$PWD/wine-ge.tar.xz" ] && echo "download failed" && exit || echo "wine-ge.tar.xz downloaded"
echo "extracting wine-ge" && tar -xvf "$PWD/wine-ge.tar.xz" > /dev/null && mv "wine" "$BINDIR/wine"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; fi; done
