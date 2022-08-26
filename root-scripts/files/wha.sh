#!/bin/bash
wine-tkg() { [ -x "/bin/wine-tkg" ] && echo "detected wine-tkg on system" && exit || echo "wine-tkg not detected locally"
[ -x "$BINDIR/wine/bin/wine" ]  && echo "wine-tkg found on relative path" && exit || echo "wine-tkg not found on relative path"
[ ! -f "$PWD/wine-tkg.tar.lzma" ] && echo "wine-tkg.tar.lzma not found, downloading" && URL="$(curl -s https://api.github.com/repos/jc141x/wine-tkg-git/releases | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}' | head -n 1)" && curl -L "$URL" -o "wine-tkg.tar.lzma"
[ ! -f "$PWD/wine-tkg.tar.lzma" ] && echo "download failed" && exit || echo "wine-tkg.tar.lzma downloaded"
echo "extracting wine-tkg" && tar -xvf "$PWD/wine-tkg.tar.lzma" > /dev/null && mv "wine" "$BINDIR/wine"; }

wine-ge() { [ -x "/bin/wine-ge" ] && echo "detected wine-ge on system" && exit || echo "wine-ge not detected locally"
[ -x "$BINDIR/wine/bin/wine" ]  && echo "wine-ge found on relative path" && exit || echo "wine-ge not found on relative path"
[ ! -f "$PWD/wine-ge.tar.lzma" ] && echo "wine-ge.tar.lzma not found, downloading" && URL="$(curl -s https://api.github.com/repos/jc141x/wine-ge-custom/releases | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}' | head -n 1)" && curl -L "$URL" -o "wine-ge.tar.lzma"
[ ! -f "$PWD/wine-ge.tar.lzma" ] && echo "download failed" && exit || echo "wine-ge.tar.lzma downloaded"
echo "extracting wine-ge" && tar -xvf "$PWD/wine-ge.tar.lzma" > /dev/null && mv "wine" "$BINDIR/wine"; }

wine-tkg-nomingw() { [ -x "/bin/wine-tkg-nomingw" ] && echo "detected wine-tkg-nomingw on system" && exit || echo "wine-tkg-nomingw not detected locally"
[ -x "$BINDIR/wine/bin/wine" ]  && echo "wine-tkg-nomingw found on relative path" && exit || echo "wine-tkg-nomingw not found on relative path"
[ ! -f "$PWD/wine-tkg-nomingw.tar.lzma" ] && echo "wine-tkg-nomingw.tar.lzma not found, downloading" && URL="$(curl -s https://api.github.com/repos/jc141x/wine-tkg-nomingw/releases | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}' | head -n 1)" && curl -L "$URL" -o "wine-tkg-nomingw.tar.lzma"
[ ! -f "$PWD/wine-tkg-nomingw.tar.lzma" ] && echo "download failed" && exit || echo "wine-tkg-nomingw.tar.lzma downloaded"
echo "extracting wine-tkg-nomingw" && tar -xvf "$PWD/wine-tkg-nomingw.tar.lzma" > /dev/null && mv "wine" "$BINDIR/wine"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; fi; done
