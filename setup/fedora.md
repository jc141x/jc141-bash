<h3>Setup Guide - Fedora</h3>

#### core packages
```sh
sudo dnf copr enable jc141/DwarFS && sudo dnf install fuse-overlayfs dwarfs wine
```

#### graphics packages

```sh
# Universal
sudo dnf install vulkan vulkan-loader

# NVIDIA specific
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install xorg-x11-drv-nvidia akmod-nvidia
```

#### other libraries
```sh
sudo dnf install libxcrypt zlib alsa-lib alsa-plugins-pulseaudio fluidsynth pulseaudio openal
```
