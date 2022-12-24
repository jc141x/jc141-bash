### Setup Guide - Arch Linux

This guide will allow you to set up our releases on an Arch Linux based set up. Other GNU/Linux distributions that can use this guide include the following:
*   EndeavourOS
*   Artix
*   ArcoLinux
*   Manjaro
*   Other Arch Linux based distributions
 

#### add rumpowered repo and multilib
```sh
echo '

[rumpowered]
Server = https://jc141x.github.io/rumpowered-packages/$arch ' | sudo tee -a /etc/pacman.conf

sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

sudo pacman-key --recv-keys cc7a2968b28a04b3
sudo pacman-key --lsign-key cc7a2968b28a04b3

sudo pacman -Syyu
```

#### core packages
```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono openssl-1.1
```

#### graphics packages
```sh
Vulkan drivers (AMD/INTEL/NVIDIA)
sudo pacman -S --needed lib32-vulkan-icd-loader vulkan-icd-loader 
```
```sh
AMD drivers
sudo pacman -S --needed lib32-vulkan-radeon vulkan-radeon
```
```sh
INTEL drivers
sudo pacman -S --needed lib32-vulkan-intel vulkan-intel
```
```sh
NVIDIA drivers
sudo pacman -S --needed lib32-libglvnd lib32-nvidia-utils libglvnd nvidia
```
- AMD: Make sure you do not have amdvlk with `sudo pacman -R amdvlk`. Having it installed will cause a lot of issues.
- NVIDIA: Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.

#### various libraries required by some games
```sh
sudo pacman -S --needed lib32-giflib lib32-gnutls lib32-libxcomposite lib32-libxinerama lib32-libxslt lib32-mpg123 lib32-v4l-utils lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib giflib libgphoto2 libxcrypt-compat zlib gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav
```

#### OPTIONAL - bindtointerface - block non-LAN network activity by default
```
sudo pacman -S --needed rumpowered/bindtointerface
```

#### other notes

The arch system is supposed to be kept up to date and the releases also use software that requires latest drivers. Update your system at least weekly with:
```sh
sudo pacman -Syu
```
