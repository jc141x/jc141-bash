#!/usr/bin/env bash
# checks
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed." && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed." && exit; cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; STS="$PWD/settings.sh"; LOGO="$PWD/logo.txt.gz";
export JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ ! -d "$JCD/native" ] && mkdir -p "$JCD/native"

# dwarfs
bash "$STS" mount; zcat "$LOGO";

# auto-unmount
[ "${UNMOUNT:=1}" = "0" ] && echo "Game will not unmount automatically due to user input." || { function cleanup { cd "$OLDPWD" && bash "$STS" unmount; }; trap 'cleanup' EXIT INT SIGINT SIGTERM; echo "Game will unmount automatically once all child processes close. Can be disabled with UNMOUNT=0."; }

# bwrap
bubblewrap_run () { [ -n "${WAYLAND_DISPLAY}" ] && export wayland_socket="${WAYLAND_DISPLAY}" || export wayland_socket="wayland-0"
[ -z "${XDG_RUNTIME_DIR}" ] && export XDG_RUNTIME_DIR="/run/user/${EUID}"
[ "${BLOCK_NET:=1}" = "0" ] && echo "network blocking is not enabled due to user input." || UNSHARE="--unshare-net" && echo "network blocking enabled. Can disable with BLOCK_NET=0. (if on Nvidia proprietary driver then its still disabled)";

if [ -n "${HOME}" ] && [ "$(echo "${HOME}" | head -c 6)" != "/home/" ]; then HOME_BASE_DIR="$(echo "${HOME}" | cut -d '/' -f2)"
case "${HOME_BASE_DIR}" in tmp|mnt|media|run|var) ;; *)
NEW_HOME=/home/"${USER}"; SPHOME+=(--tmpfs /home --bind "${HOME}" "${NEW_HOME}" --setenv "HOME" "${NEW_HOME}") ;; esac; fi

if [ -n "${HOME_DIR}" ]; then if [ -n "${SPHOME[*]}" ]; then VAR+=(--bind "${HOME_DIR}" "${NEW_HOME}")
else VAR+=(--ro-bind "${HOME_DIR}" "${HOME}"); fi; [ ! -d "${HOME_DIR}" ] && mkdir -p "${HOME_DIR}"; fi

[ -z "${XAUTH}" ] && XAUTH="${HOME}"/.Xauthority
[ -n "${SPHOME[*]}" ] && [ "${XAUTH}" = "${HOME}"/.Xauthority ] && VAR+=(--ro-bind-try "${XAUTH}" "${NEW_HOME}"/.Xauthority --setenv "XAUTHORITY" "${NEW_HOME}"/.Xauthority) || VAR+=(--ro-bind-try "${XAUTH}" "${XAUTH}")
for s in /tmp/.X11-unix/*; do VAR+=(--bind-try "${s}" "${s}"); done
[ -n "${SPHOME[*]}" ] && VAR+=(--dir "${NEW_HOME}")

bwrap --ro-bind / / --dev-bind /dev /dev --ro-bind /sys /sys- --proc /proc \
      --ro-bind-try /mnt /mnt --ro-bind-try /run /run --ro-bind-try /var /var --ro-bind-try /etc/resolv.conf /etc/resolv.conf \
      --ro-bind-try /etc/hosts /etc/hosts --ro-bind-try /etc/nsswitch.conf /etc/nsswitch.conf --tmpfs /tmp/.X11-unix \
      --ro-bind-try /etc/passwd /etc/passwd --ro-bind-try /etc/group /etc/group --ro-bind-try /etc/machine-id /etc/machine-id \
      --ro-bind-try /etc/asound.conf /etc/asound.conf --new-session --bind-try /opt /opt --tmpfs /tmp --new-session \
      --ro-bind-try /usr/lib64 /usr/lib64 --ro-bind-try /usr/lib /usr/lib \
      --ro-bind "$JCD"/native / "${VAR[@]}" "${SPHOME[@]}" $BLOCK_NET "$@"; }

# start
[ "${ISOLATION:=1}" = "0" ] && echo "Isolation is disabled." && BUBBLEWRAP="" || echo "Isolation is enabled." && BUBBLEWRAP=bubblewrap_run; [ ! -x "$(command -v bwrap)" ] && BUBBLEWRAP="" && echo "Isolation not enabled due to no bwrap package installed."; [ -f "/bin/nvidia-modprobe" ] && BUBBLEWRAP="" && echo "Isolation disabled, not supported on Nvidia proprietary driver."
echo "For any misunderstandings or need of support, join the community on Matrix."
[ "${DBG:=0}" = "1" ] || { echo "Output muted by default to avoid performance impact. Can unmute with DBG=1." && exec &>/dev/null; }
cd "$PWD/files/groot"; $BUBBLEWRAP ./"game.bin" "$@"
