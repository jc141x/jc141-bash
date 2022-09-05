<h3>Setup Guide - Arch</h3>

- Also applies to EndeavourOS, Artix, ArcoLinux, Manjaro etc.

### pre-configuration

#### add rumpowered repo and multilib
```sh
echo '

[rumpowered]
SigLevel = Never
Server = https://repo.rumpowered.org/$arch ' | sudo tee -a /etc/pacman.conf

sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

sudo pacman -Syyu
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
```

#### wine-staging-tkg + wine-mono + dxvk + vkd3d (offline support)
```sh
sudo pacman -S --needed rumpowered/wine-staging-tkg rumpowered/dxvk-bin rumpowered/vkd3d-proton-bin rumpowered/windep wine-mono
```

#### various libraries required by some games
```sh
sudo pacman -S --needed lib32-giflib lib32-gnutls lib32-libxcomposite lib32-libxinerama lib32-libxslt lib32-mpg123 lib32-v4l-utils lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib giflib libgphoto2 libxcrypt-compat zlib aria2
```

#### gstreamer
```sh
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

yay -S --needed gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav
# 32bit
yay -S --needed lib32-gst-plugins-base lib32-gst-plugins-good rumpowered/lib32-gst-plugins-ugly lib32-gst-plugins-bad
```

-------------------------------------------------------------------------------------------------------------------

### optional packages

#### gamescope
- highly recommended
- Nvidia not supported yet
- requires full vulkan support, old architectures with none or semi are not compatible

```sh
sudo pacman -S --needed gamescope
```
