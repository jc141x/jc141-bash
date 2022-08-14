<h3>Setup Guide - Arch</h3>

- Also applies to EndeavourOS, Artix, ArcoLinux, Manjaro etc.

- This is based on the assumption that you have common packages that come on distros like EndeavourOS, so on bare Arch you may have to install additional libraries.

#### rumpowered arch repo
```sh
echo '

[rumpowered]
SigLevel = Never
Server = https://repo.rumpowered.org/$arch ' | sudo tee -a /etc/pacman.conf

sudo pacman -Syyu
```

#### dwarfs and fuse-overlayfs
```sh
sudo pacman -S --needed rumpowered/dwarfs-bin fuse-overlayfs
```

#### multilib
```sh
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf && sudo pacman -Syyu
```

#### yay
- Does not apply to EndeavourOS.
```sh
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
```

#### aria2

```sh
sudo pacman -S aria2
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
#### wine-staging-tkg + wine-mono + dxvk + vkd3d
```sh
sudo pacman -S --needed rumpowered/wine-staging-tkg rumpowered/dxvk-bin rumpowered/vkd3d-proton-bin wine-mono
```
- Using AUR versions of dxvk and vkd3d will cause exponentially bigger disk usage in files/user-data. (duplicates wineprefix files)

#### gamescope
- optional but recommended

```
sudo pacman -S --needed gamescope
```

- Nvidia not supported yet. Meanwhile don't install it or it will get used and fail to boot games. This also applies to old GPUs with no vulkan support or semi-supported.

#### multilib libraries

```sh
sudo pacman -S --needed lib32-giflib lib32-gnutls lib32-libxcomposite lib32-libxinerama lib32-libxslt lib32-mpg123 lib32-v4l-utils lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib
```

#### gstreamer
- expect some packages to fail at building process, we will create our own packages eventually.

```
yay -S lib32-gst-plugins-base gst-plugins-base lib32-gst-plugins-good gst-plugins-good lib32-gst-plugins-ugly gst-plugins-ugly lib32-gst-plugins-bad gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-libav
```

#### other libraries
```sh
sudo pacman -S --needed giflib jq libgphoto2 libxcrypt-compat zlib
```

#### optional packages

##### yuzu

```sh
sudo pacman -S rumpowered/yuzu-mainline-bin
```
