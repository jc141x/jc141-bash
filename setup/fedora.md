<h3>Setup Guide - Fedora</h3>

#### dwarfs and fuse-overlayfs
Dwarfs isn't available in the repos and copr, so our temporarily solution is this rpm we made.
```sh
wget -qO ~/Downloads/dwarfs-0.6.1-1.fc36.x86_64.rpm https://github.com/jc141x/jc141-bash/releases/download/420/dwarfs-0.6.1-1.fc36.x86_64.rpm && sudo dnf install ~/Downloads/dwarfs-0.6.1-1.fc36.x86_64.rpm
sudo dnf install fuse-overlayfs
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
sudo dnf install libxcrypt zlib aria2 alsa-lib alsa-plugins fluidsynth pulseaudio openal
```

#### optional packages

##### gamescope
- highly recommended
- Nvidia not supported yet
- requires full vulkan support, old architectures with none or semi are not compatible
```sh
sudo dnf install gamescope
```
