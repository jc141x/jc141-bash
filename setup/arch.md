<h3>Setup Guide - Arch</h3>

- Also applies to EndeavourOS, Artix, ArcoLinux, Manjaro etc.

### pre-configuration

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


------------------------------------------------------------------------------------------------------

### main packages

#### dwarfs and fuse-overlayfs
```sh
sudo pacman -S --needed rumpowered/dwarfs-bin fuse-overlayfs
```

#### AMD graphics packages
```sh
sudo pacman -S --needed lib32-vulkan-icd-loader vulkan-icd-loader lib32-vulkan-radeon vulkan-radeon && sudo pacman -R amdvlk
```

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
sudo pacman -S --needed lib32-giflib lib32-gnutls lib32-libxcomposite lib32-libxinerama lib32-libxslt lib32-mpg123 lib32-v4l-utils lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib giflib libgphoto2 libxcrypt-compat zlib
```

#### gstreamer (video rendering)
```sh
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

yay -S --needed gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav
# 32bit
yay -S --needed lib32-gst-plugins-base lib32-gst-plugins-good rumpowered/lib32-gst-plugins-ugly lib32-gst-plugins-bad
```

-------------------------------------------------------------------------------------------------------------------

### optional packages

#### gamescope
- Nvidia not supported yet.
- Requires full vulkan support, old architectures with none or semi are not compatible.
- May cause failure to run from first try in certain cases.
- Isolates system display server from game, no desktop res changing when in use.

```sh
sudo pacman -S --needed gamescope
```

#### bindtointerface - block non-LAN network activity by default
```
sudo pacman -S --needed rumpowered/bindtointerface
```
