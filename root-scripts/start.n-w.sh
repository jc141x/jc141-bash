#!/usr/bin/env bash
# checks
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed." && exit; [ ! -x "$(command -v bwrap)" ] && echo "bubblewrap not installed." && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed." && exit; cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; export JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ ! -d "$JCD/wine" ] && mkdir -p "$JCD/wine"
[ -f "/bin/nvidia-modprobe" ] && MODPROBE="--ro-bind /usr/bin/true /usr/bin/nvidia-modprobe"
[ "${ISOLATION:=1}" = "0" ] ||  { echo "Bubblewrap isolation is enabled." && BWRAP="bwrap $UNSHARE --ro-bind /usr /usr --symlink usr/bin /bin --symlink usr/bin /sbin --symlink usr/lib /lib --symlink usr/lib /lib64 --ro-bind /opt /opt --dev /dev --tmpfs /var --tmpfs /tmp --tmpfs /run --dir /run/user/$UID --ro-bind /etc /etc --proc /proc --bind "$JCD"/native $HOME --ro-bind $HOME/.Xauthority $HOME/.Xauthority --unshare-all --setenv PATH /usr/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl --bind "$(pwd)/" "$(pwd)/" --ro-bind-try "${XDG_RUNTIME_DIR}"/"${wayland_socket}" "${XDG_RUNTIME_DIR}"/"${wayland_socket}"" && export WANBLOCK=0; }
[ "${WANBLOCK:=1}" = "0" ] || { echo "WAN blocking enabled." && UNSHARE="--unshare-net"; }

# wine
export WINE="$(command -v wine)";
export WINEPREFIX="$JCD/wine/native-prefix"; export WINEDLLOVERRIDES="winemenubuilder.exe=d;mshtml=d"; export WINE_LARGE_ADDRESS_AWARE=1; export RESTORE_RESOLUTION=1; export WINE_D3D_CONFIG="renderer=vulkan" && echo "wined3d vulkan renderer is used.";

# dwarfs
bash "$PWD/settings.sh" mount; zcat "$PWD/logo.txt.gz"; echo "Path of the wineprefix is: $WINEPREFIX";

# auto-unmount
[ "${UNMOUNT:=1}" = "0" ] && echo "Game will not unmount automatically due to user input." || { function cleanup { cd "$OLDPWD" && bash "$PWD/settings.sh" unmount; }; trap 'cleanup' EXIT INT SIGINT SIGTERM; echo "Game will unmount automatically once all child processes close. Can be disabled with UNMOUNT=0."; }

# start
echo "For any misunderstandings or need of support, join the community on Matrix."
[ "${DBG:=0}" = "1" ] || { export WINEDEBUG='-all' && echo "Output muted by default to avoid performance impact. Can unmute with DBG=1." && exec &>/dev/null; }
cd "$PWD/files/groot"; $BWRAP "$WINE" "game.exe" "$@"
