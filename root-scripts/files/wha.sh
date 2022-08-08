#!/bin/bash
wine-tkg() { [ -x "/bin/wine-tkg" ] && echo -n "detected wine-tkg on system. | " && exit || echo -n "wine-tkg not detected locally | "
[ -x "$BINDIR/wine/bin/wine" ]  && echo -n "wine-tkg found on relative path. | " && exit || echo -n "wine-tkg not found on relative path | "
[ ! -f "$PWD/wine-tkg.tar.lzma" ] && echo -n "wine-tkg.tar.lzma not found, downloading | " && URL="$(curl -s https://api.github.com/repos/jc141x/wine-tkg-git/releases | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}' | head -n 1)" && curl -L "$URL" -o "wine-tkg.tar.lzma"
[ ! -f "$PWD/wine-tkg.tar.lzma" ] && echo -n "download failed | " && exit || echo -n "wine-tkg.tar.lzma downloaded | "
echo -n "extracting wine-tkg. | " && tar -xvf "$PWD/wine-tkg.tar.lzma" > /dev/null && mv "wine" "$BINDIR/wine"; }

wine-ge() { [ -x "/bin/wine-ge" ] && echo -n "detected wine-ge on system | " && exit || echo -n "wine-ge not detected locally | "
[ -x "$BINDIR/wine/bin/wine" ]  && echo -n "wine-ge found on relative path | " && exit || echo -n "wine-ge not found on relative path | "
[ ! -f "$PWD/wine-ge.tar.lzma" ] && echo -n "wine-ge.tar.lzma not found, downloading | " && URL="$(curl -s https://api.github.com/repos/jc141x/wine-ge-custom/releases | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}' | head -n 1)" && curl -L "$URL" -o "wine-ge.tar.lzma"
[ ! -f "$PWD/wine-ge.tar.lzma" ] && echo -n "download failed | " && exit || echo -n "wine-ge.tar.lzma downloaded | "
echo -n "extracting wine-ge. | " && tar -xvf "$PWD/wine-ge.tar.lzma" > /dev/null && mv "wine" "$BINDIR/wine"; }

wine-tkg-nomingw() { [ -x "/bin/wine-tkg-nomingw" ] && echo -n "detected wine-tkg-nomingw on system | " && exit || echo -n "wine-tkg-nomingw not detected locally. | "
[ -x "$BINDIR/wine/bin/wine" ]  && echo -n "wine-tkg-nomingw found on relative path. | " && exit || echo -n "wine-tkg-nomingw not found on relative path. | "
[ ! -f "$PWD/wine-tkg-nomingw.tar.lzma" ] && echo -n "wine-tkg-nomingw.tar.lzma not found, downloading | " && URL="$(curl -s https://api.github.com/repos/jc141x/wine-tkg-nomingw/releases | awk -F '["]' '/"browser_download_url":/ && /tar.lzma/ {print $4}' | head -n 1)" && curl -L "$URL" -o "wine-tkg-nomingw.tar.lzma"
[ ! -f "$PWD/wine-tkg-nomingw.tar.lzma" ] && echo -n "download failed | " && exit || echo -n "wine-tkg-nomingw.tar.lzma downloaded. | "
echo -n "extracting wine-tkg-nomingw. | " && tar -xvf "$PWD/wine-tkg-nomingw.tar.lzma" > /dev/null && mv "wine" "$BINDIR/wine"; }

for i in "$@"; do if type "$i" &>/dev/null; then "$i"; fi; done
