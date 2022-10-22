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

#### wine + wine-mono
```sh
sudo dnf install wine wine-mono
```

- Fedora does not provide wine-staging. Unexpected issues can occur.

#### other libraries
```sh
sudo dnf install libxcrypt zlib alsa-lib alsa-plugins fluidsynth pulseaudio openal
```

#### optional packages

##### gamescope
Isolates game from system display server, no desktop res changing when in use. As well as forcing games into fullscreen and scaling when necessary. Can provide AMD FidelityFX Super Resolution or NVIDIA Image Scaling support.

```sh
sudo dnf install gamescope
```

- NVIDIA drivers may have some issues with this.
- Requires **full** Vulkan support. (old architectures with none or semi are not compatible)
- May cause failure to run from first try in certain cases.
- Is not always used by scripts, testing is done to confirm that it is compatible.
