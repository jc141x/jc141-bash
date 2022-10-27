<h3>Setup Guide - Fedora</h3>

#### core packages
```sh
sudo dnf copr enable jc141/DwarFS && sudo dnf install fuse-overlayfs dwarfs wine wine-mono
```

#### graphics packages

```sh
# Universal
sudo dnf install vulkan vulkan-loader

# NVIDIA specific
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install xorg-x11-drv-nvidia akmod-nvidia

Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.
```

- Fedora does not provide wine-staging. Unexpected issues can occur.

#### other libraries
```sh
sudo dnf install libxcrypt zlib alsa-lib alsa-plugins fluidsynth pulseaudio openal
```
