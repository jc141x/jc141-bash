### Setup Guide - OpenSUSE Tumbleweed

#### core packages
```sh
sudo zypper ar https://download.opensuse.org/repositories/home:/jc141/openSUSE_Tumbleweed/home:jc141.repo
sudo zypper refresh
sudo zypper install dwarfs fuse-overlayfs wine-staging wine-mono
```

#### graphics packages
```sh
Vulkan drivers
sudo zypper install libvulkan1 vulkan-tools
AMD drivers
sudo zypper install libvulkan_radeon libvulkan_radeon-32bit
INTEL drivers
sudo zypper install libvulkan_intel libvulkan_intel-32bit
NVIDIA drivers (guide incomplete for now)
sudo zypper install libglvnd-32bit libglvnd
```
- NVIDIA: Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.

#### various libraries required by some games
```sh
sudo zypper install giflib-devel-32bit libXcomposite-devel-32bit libXinerama-devel-32bit libxslt-devel-32bit mpg123-devel-32bit mpg123-openal-32bit zlib-devel-32bit libpulse-devel-32bit giflib-devel libgphoto2-6 zlib-devel libva2 gstreamer-plugins-base gstreamer-plugins-good gstreamer-plugins-ugly gstreamer-plugins-bad gstreamer-plugins-vaapi gstreamer-plugins-libav
```
