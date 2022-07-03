<h2>Setup Guide - Arch</h2>

- Also applies to EndeavourOS, Artix, ArcoLinux, Manjaro etc.

- This is based on the assumption that you have common packages that come on distros like EndeavourOS, so on bare Arch you may have to install additional libraries.

### YAY
- Does not apply to EndeavourOS.
```sh
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
```

### DWARFS
```sh
yay -S dwarfs-bin fuse-overlayfs
```

### ZPAQ
```sh
git clone https://aur.archlinux.org/zpaq.git && cd zpaq && makepkg -si
```

### MULTILIB
```sh
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf && sudo pacman -Syyu
```

### GRAPHICS Packages

```sh
# Universal
sudo pacman -S --needed gamescope lib32-vulkan-icd-loader vulkan-icd-loader
Gamescope not supported on Nvidia yet, but coming soon. Meanwhile don't install it or it will get used and fail to boot games.

# INTEL specific
sudo pacman -S --needed lib32-vulkan-intel vulkan-intel

# AMD specific
sudo pacman -S --needed lib32-vulkan-radeon vulkan-radeon
sudo pacman -R amdvlk

# NVIDIA specific
sudo pacman -S --needed lib32-libglvnd lib32-nvidia-utils libglvnd nvidia

Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.

# NVIDIA legacy (ignore above commands for NVIDIA if GPU is old, GTX 700 etc)
yay -S --needed lib32-libglvnd lib32-nvidia-470xx-utils libglvnd nvidia-470xx-dkms
```

- NVIDIA legacy: check [Nvidia's  website](https://nvidia.custhelp.com/app/answers/detail/a_id/3142) for details on which version is right for your GPU.

### Other libraries
```sh
sudo pacman -S --needed giflib jq libgphoto2 libxcrypt-compat zlib
```

### MULTILIB libraries

```sh
sudo pacman -S --needed lib32-giflib lib32-gnutls lib32-libxcomposite lib32-libxinerama lib32-libxslt lib32-mpg123 lib32-v4l-utils lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib
```

### GSTREAMER
```
yay -S lib32-gst-plugins-base gst-plugins-base lib32-gst-plugins-good gst-plugins-good lib32-gst-plugins-ugly gst-plugins-ugly lib32-gst-plugins-bad gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-libav
```

### Wine-staging-tkg
```sh
echo '

[rumpowered]
SigLevel = Never
Server = https://repo.rumpowered.org/$arch ' | sudo tee -a /etc/pacman.conf

sudo pacman -Syyu

sudo pacman -S --needed wine-staging-tkg
```

## Optional packages

#### Yuzu - for Nintendo games

```sh
yay -S yuzu-mainline-bin
```
#### Dosbox
```sh
sudo pacman -S --needed dosbox
```
