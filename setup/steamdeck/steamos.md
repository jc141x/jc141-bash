## Setup Guide - SteamDeck - SteamOS

- Report issues you are having to us on matrix.
- We recommend the installation of a malware free GNU/Linux system. For that we currently support [Arch/EndeavourOS/Others](arch.md).

#### add required repos and enable rwfus

```sh
git clone https://github.com/ValShaped/rwfus.git
cd rwfus
./rwfus -iI

echo '
[rumpowered]
SigLevel = Never
Server = https://repo.rumpowered.org/$arch
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman -Sy
```

#### core packages
```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono openssl-1.1
```

#### graphics packages
```sh
sudo pacman -S --needed lib32-vulkan-icd-loader vulkan-icd-loader lib32-vulkan-radeon vulkan-radeon
```

#### various libraries required by some games
```sh
sudo pacman -S --needed lib32-giflib lib32-gnutls lib32-libxcomposite lib32-libxinerama lib32-libxslt lib32-mpg123 lib32-v4l-utils lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib giflib libgphoto2 libxcrypt-compat zlib gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav
```
