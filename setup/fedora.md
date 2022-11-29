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

Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.
```

#### other libraries
```sh
sudo dnf install libxcrypt zlib alsa-lib alsa-plugins fluidsynth pulseaudio openal
```

<h3>Silverblue alternate setup (not throughly tested)</h3>

#### core packages
```sh
cd /etc/yum.repos.d && sudo wget https://copr.fedorainfracloud.org/coprs/jc141/DwarFS/repo/fedora-37/jc141-DwarFS-fedora-37.repo
rpm-ostree install wine fuse-overlayfs dwarfs --apply-live
```

#### graphics packages

```sh
# Universal
rpm-ostree install vulkan vulkan-loader --apply-live

# NVIDIA specific
rpm-ostree install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm --apply-live && rpm-ostree install xorg-x11-drv-nvidia akmod-nvidia --apply-live

Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.
```

#### other libraries
```sh
rpm-ostree install libxcrypt zlib alsa-lib alsa-plugins fluidsynth pulseaudio openal --apply-live
```
