#!/usr/bin/env bash
# checks
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed." && exit; [ ! -x "$(command -v bwrap)" ] && echo "bubblewrap not installed." && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed." && exit; cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; STS="$PWD/settings.sh"; LOGO="$PWD/logo.txt.gz";
export JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ ! -d "$JCD/native" ] && mkdir -p "$JCD/native"
[ "${WANBLOCK:=1}" = "0" ] || { echo "WAN blocking enabled." && UNSHARE="--unshare-net"; }
[ -f "/bin/nvidia-modprobe" ] && MODPROBE="--ro-bind /usr/bin/true /usr/bin/nvidia-modprobe"; [ -f "$HOME/.Xauthority" ] && XAUTH="--ro-bind $HOME/.Xauthority $HOME/.Xauthority"; [ -f "/tmp/.X11-unix" ] && X11="--ro-bind /tmp/.X11-unix /tmp/.X11-unix";
[ "${ISOLATION:=1}" = "0" ] ||  { echo "Bubblewrap isolation is enabled." && BWRAP="bwrap $MODPROBE $UNSHARE $XAUTH $X11 --ro-bind /usr /usr --symlink usr/bin /bin --symlink usr/bin /sbin --symlink usr/lib /lib --symlink usr/lib /lib64 --ro-bind /opt /opt --dev /dev --dev-bind /dev/dri /dev/dri --bind /sys /sys --tmpfs /var --tmpfs /tmp --tmpfs /run --dir /run/user/$UID --ro-bind /etc /etc --proc /proc --bind "$JCD"/native $HOME --setenv PATH /usr/bin:/bin:/usr/local/sbin:/usr/local/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl --bind "$(pwd)/" "$(pwd)/" --ro-bind-try "${XDG_RUNTIME_DIR}"/"${wayland_socket}" "${XDG_RUNTIME_DIR}"/"${wayland_socket}""; }

# dwarfs
bash "$STS" mount; zcat "$LOGO";

# auto-unmount
[ "${UNMOUNT:=1}" = "0" ] && echo "Game will not unmount automatically due to user input." || { function cleanup { cd "$OLDPWD" && bash "$STS" unmount; }; trap 'cleanup' EXIT INT SIGINT SIGTERM; echo "Game will unmount automatically once all child processes close. Can be disabled with UNMOUNT=0."; }

# start
echo "For any misunderstandings or need of support, join the community on Matrix."
[ "${DBG:=0}" = "1" ] || { echo "Output muted by default to avoid performance impact. Can unmute with DBG=1." && exec &>/dev/null; }
cd "$PWD/files/groot"; $BWRAP ./"game.bin" "$@"
