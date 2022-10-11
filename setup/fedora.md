<h3>Setup Guide - Fedora</h3>

#### dwarfs and fuse-overlayfs
```sh
sudo dnf copr enable linuxredneck/DwarFS && sudo dnf install fuse-overlayfs dwarfs
```

#### graphics packages

```sh
# Universal
sudo dnf install vulkan vulkan-loader

# NVIDIA specific
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install xorg-x11-drv-nvidia akmod-nvidia

Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.
```

#### wine-mono
```sh
sudo dnf install wine-mono
```

#### other libraries
```sh
sudo dnf install libxcrypt zlib alsa-lib alsa-plugins fluidsynth pulseaudio openal
```

#### optional packages

##### gamescope

- Nvidia not supported yet
```sh
sudo dnf install gamescope
```
