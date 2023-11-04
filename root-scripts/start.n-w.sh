#!/usr/bin/env bash
# checks
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed." && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed." && exit; cd "$(dirname "$(readlink -f "$0")")" || exit; [ "$EUID" = "0" ] && exit; export JCD="${XDG_DATA_HOME:-$HOME/.local/share}/jc141"; [ ! -d "$JCD/wine" ] && mkdir -p "$JCD/wine"

# wine
export WINE="$(command -v wine)";
export WINEPREFIX="$JCD/wine/native-prefix"; export WINEDLLOVERRIDES="winemenubuilder.exe=d;mshtml=d"; export WINE_LARGE_ADDRESS_AWARE=1; export RESTORE_RESOLUTION=1; export WINE_D3D_CONFIG="renderer=vulkan" && echo "wined3d vulkan renderer is used.";

# dwarfs
bash "$PWD/settings.sh" mount; zcat "$PWD/logo.txt.gz"; echo "Path of the wineprefix is: $WINEPREFIX";

# auto-unmount
[ "${UNMOUNT:=1}" = "0" ] && echo "Game will not unmount automatically due to user input." || { function cleanup { cd "$OLDPWD" && bash "$PWD/settings.sh" unmount; }; trap 'cleanup' EXIT INT SIGINT SIGTERM; echo "Game will unmount automatically once all child processes close. Can be disabled with UNMOUNT=0."; }

# block WAN
[ ! -f "/usr/lib64/bindToInterface.so" ] && echo "bindtointerface package not installed, no WAN blocking." || [ "${WANBLK:=1}" = "0" ] && echo "WAN blocking is not enabled due to user input." || { export BIND_INTERFACE=lo; export BIND_EXCLUDE=10.,172.16.,192.168.; export LD_PRELOAD='/usr/$LIB/bindToInterface.so'; echo "bindtointerface WAN blocking enabled. Can disable with WANBLK=0."; }

# bwrap
bubblewrap_run () { [ -n "${WAYLAND_DISPLAY}" ] && export wayland_socket="${WAYLAND_DISPLAY}" || export wayland_socket="wayland-0"
[ -z "${XDG_RUNTIME_DIR}" ] && export XDG_RUNTIME_DIR="/run/user/${EUID}"
[ -f "/bin/nvidia-modprobe" ] && MODPROBE="--ro-bind /usr/bin/true /usr/bin/nvidia-modprobe";

if [ -n "${HOME}" ] && [ "$(echo "${HOME}" | head -c 6)" != "/home/" ]; then HOME_BASE_DIR="$(echo "${HOME}" | cut -d '/' -f2)"
case "${HOME_BASE_DIR}" in tmp|mnt|media|run|var) ;; *)
NEW_HOME=/home/"${USER}"; SPHOME+=(--tmpfs /home --bind "${HOME}" "${NEW_HOME}" --setenv "HOME" "${NEW_HOME}") ;; esac; fi

if [ -n "${HOME_DIR}" ]; then if [ -n "${SPHOME[*]}" ]; then VAR+=(--bind "${HOME_DIR}" "${NEW_HOME}")
else VAR+=(--ro-bind "${HOME_DIR}" "${HOME}"); fi; [ ! -d "${HOME_DIR}" ] && mkdir -p "${HOME_DIR}"; fi

[ -z "${XAUTH}" ] && XAUTH="${HOME}"/.Xauthority
[ -n "${SPHOME[*]}" ] && [ "${XAUTH}" = "${HOME}"/.Xauthority ] && VAR+=(--ro-bind-try "${XAUTH}" "${NEW_HOME}"/.Xauthority --setenv "XAUTHORITY" "${NEW_HOME}"/.Xauthority) || VAR+=(--ro-bind-try "${XAUTH}" "${XAUTH}")
for s in /tmp/.X11-unix/*; do VAR+=(--bind-try "${s}" "${s}"); done
[ -n "${SPHOME[*]}" ] && VAR+=(--dir "${NEW_HOME}")

bwrap --bind / / --dev-bind /dev /dev --ro-bind /sys /sys --ro-bind-try /tmp /tmp --proc /proc \
	--ro-bind-try /mnt /mnt --ro-bind-try /run /run --ro-bind-try /var /var --ro-bind-try /etc/resolv.conf /etc/resolv.conf \
	--ro-bind-try /etc/hosts /etc/hosts --ro-bind-try /etc/nsswitch.conf /etc/nsswitch.conf --tmpfs /tmp/.X11-unix \
	--ro-bind-try /etc/passwd /etc/passwd --ro-bind-try /etc/group /etc/group --ro-bind-try /etc/machine-id /etc/machine-id \
	--ro-bind-try /etc/asound.conf /etc/asound.conf --new-session --bind-try /opt /opt --tmpfs /tmp --new-session \
	--ro-bind-try /usr/lib64 /usr/lib64 \
	--ro-bind-try /usr/lib /usr/lib \
	--ro-bind-try /usr/lib/x86_64-linux-gnu/nvidia/current /usr/lib/x86_64-linux-gnu/nvidia/current \
	--ro-bind-try /usr/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu \
	--ro-bind "$JCD"/wine "$JCD"/wine "${VAR[@]}" "${SPHOME[@]}" $MODPROBE "$@"; }

# start
[ "${ISOLATION:=1}" = "0" ] && echo "Isolation is disabled." && BUBBLEWRAP="" || echo "Isolation is enabled." && BUBBLEWRAP=bubblewrap_run; [ ! -x "$(command -v bwrap)" ] && BUBBLEWRAP="" && echo "Isolation not enabled due to no bwrap package installed."; [ -f "/bin/nvidia-modprobe" ] && BUBBLEWRAP="" && echo "Isolation disabled, not supported on Nvidia proprietary driver yet."
echo "For any misunderstandings or need of support, join the community on Matrix."
[ "${DBG:=0}" = "1" ] || { export WINEDEBUG='-all' && echo "Output muted by default to avoid performance impact. Can unmute with DBG=1." && exec &>/dev/null; }
cd "$PWD/files/groot"; $WINE "game.exe" "$@"
