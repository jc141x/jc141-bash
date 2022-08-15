<h3>Setup Guide - Arch</h3>

- Also applies to EndeavourOS, Artix, ArcoLinux, Manjaro etc.

### pre-configuration

#### rumpowered arch repo
```sh
echo '

[rumpowered]
SigLevel = Never
Server = https://repo.rumpowered.org/$arch ' | sudo tee -a /etc/pacman.conf

sudo pacman -Syyu
```

#### multilib
```sh
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf && sudo pacman -Syyu
```

#### yay
```sh
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
```

------------------------------------------------------------------------------------------------------

### main packages

#### dwarfs and fuse-overlayfs
```sh
sudo pacman -S --needed rumpowered/dwarfs-bin fuse-overlayfs
```

#### graphics packages

```sh
# Universal
sudo pacman -S --needed lib32-vulkan-icd-loader vulkan-icd-loader

# INTEL specific
sudo pacman -S --needed lib32-vulkan-intel vulkan-intel

# AMD specific
sudo pacman -S --needed lib32-vulkan-radeon vulkan-radeon
sudo pacman -R amdvlk

# NVIDIA specific
sudo pacman -S --needed lib32-libglvnd lib32-nvidia-utils libglvnd nvidia

Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.

kepler architecture support (TITAN, 7xx, 6xx)
yay -S --needed lib32-nvidia-470xx-utils nvidia-470xx-dkms
```

#### wine-staging-tkg + wine-mono + dxvk + vkd3d (offline support)
```sh
sudo pacman -S --needed rumpowered/wine-staging-tkg rumpowered/dxvk-bin rumpowered/vkd3d-proton-bin rumpowered/windep wine-mono
```
- Using AUR versions of dxvk and vkd3d will cause exponentially bigger disk usage in files/user-data. (duplicates wineprefix files)

#### gstreamer
```
yay -S --needed gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav
32bit
yay -S --needed lib32-gst-plugins-base lib32-gst-plugins-good lib32-gst-plugins-ugly lib32-gst-plugins-bad
```

#### multilib libraries
```sh
sudo pacman -S --needed lib32-giflib lib32-gnutls lib32-libxcomposite lib32-libxinerama lib32-libxslt lib32-mpg123 lib32-v4l-utils lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib
```

#### other libraries
```sh
sudo pacman -S --needed giflib libgphoto2 libxcrypt-compat zlib aria2
```

-------------------------------------------------------------------------------------------------------------------

### optional packages

#### gamescope
- highly recommended
- Nvidia not supported yet
- requires full vulkan support, old architectures with none or semi are not compatible

```
sudo pacman -S --needed gamescope
```

#### yuzu
- for Nintendo
```sh
sudo pacman -S --needed rumpowered/yuzu-mainline-bin
```
