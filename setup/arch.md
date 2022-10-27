<h3>Setup Guide - Arch</h3>

- Also applies to EndeavourOS, Artix, ArcoLinux, Manjaro etc.

#### add rumpowered repo and multilib
```sh
echo '

[rumpowered]
Server = https://jc141x.github.io/rumpowered-packages/$arch
Server = https://repo.rumpowered.org/$arch ' | sudo tee -a /etc/pacman.conf

sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

sudo pacman-key --recv-keys cc7a2968b28a04b3
sudo pacman-key --lsign-key cc7a2968b28a04b3

sudo pacman -Syyu
```

#### dwarfs and fuse-overlayfs
```sh
sudo pacman -S --needed rumpowered/dwarfs-bin fuse-overlayfs
```

#### AMD graphics packages
```sh
sudo pacman -S --needed lib32-vulkan-icd-loader vulkan-icd-loader lib32-vulkan-radeon vulkan-radeon
```
- Make sure you do not have amdvlk with `sudo pacman -R amdvlk`. Having it installed will cause a lot of issues.

#### INTEL graphics packages

```sh
sudo pacman -S --needed lib32-vulkan-icd-loader vulkan-icd-loader lib32-vulkan-intel vulkan-intel
```

#### NVIDIA graphics packages

```sh
sudo pacman -S --needed lib32-vulkan-icd-loader vulkan-icd-loader lib32-libglvnd lib32-nvidia-utils libglvnd nvidia
```

- Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.

#### wine-staging + wine-mono
```sh
sudo pacman -S --needed wine-staging wine-mono
```
- wine-staging-tkg can be used instead of wine-staging, to the user's choice.

#### various libraries required by some games
```sh
sudo pacman -S --needed lib32-giflib lib32-gnutls lib32-libxcomposite lib32-libxinerama lib32-libxslt lib32-mpg123 lib32-v4l-utils lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib giflib libgphoto2 libxcrypt-compat zlib gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav
```

#### (OPTIONAL) bindtointerface - block non-LAN network activity by default
```
sudo pacman -S --needed rumpowered/bindtointerface
```
