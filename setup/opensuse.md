### Setup Guide - OpenSUSE Tumbleweed

#### Core packages
```sh
sudo zypper ar https://download.opensuse.org/repositories/home:/jc141/openSUSE_Tumbleweed/home:jc141.repo
sudo zypper refresh
sudo zypper install dwarfs fuse-overlayfs wine-staging wine-mono
```
<br>

#### Graphics packages
```sh
Vulkan drivers
sudo zypper install libvulkan1 vulkan-tools
AMD drivers
sudo zypper install libvulkan_radeon
INTEL drivers
sudo zypper install libvulkan_intel
NVIDIA drivers (guide incomplete for now)
sudo zypper install libglvnd-32bit libglvnd
```
<br>

#### Various libraries required by some games
```sh
sudo zypper install libpulse-devel-32bit giflib-devel libgphoto2-6 zlib-devel libva2 gstreamer-plugins-base gstreamer-plugins-good gstreamer-plugins-ugly gstreamer-plugins-bad gstreamer-plugins-vaapi gstreamer-plugins-libav
```
<br>

#### Optional - Security features

Enables start scripts to isolate game from having writing access to user space, except for the specific location of $HOME/$USER/.local/share/jc141/game-data

```
sudo zypper install bubblewrap
```
