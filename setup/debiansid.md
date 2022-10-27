<h3>Setup Guide - Debian Sid</h3>

- Also applies to Sparky Rolling, Siduction, Nitrux which are rolling by default.

#### Debian does not provide any package for wine-mono, missing it can cause crashes in specific games. It is not available on MPR either. This issue will not be fixed until the package becomes available. Alternatively, install mono when asked by wine when running our releases.

### pre-configuration

#### How to switch Debian 11 to Rolling/Sid.
```sh
1. Edit /etc/apt/sources.list:
sudo nano /etc/apt/sources.list

2. Edit sources.list to only use these repos:

deb http://deb.debian.org/debian/ sid main contrib non-free
deb-src http://deb.debian.org/debian/ sid main

3. Save the file and update your system to Sid (This will reboot your system):

sudo apt update && sudo apt full-upgrade && sudo reboot
```
- Optionally you can install `apt-listbugs apt-listchanges` to read the bugs and see if any of them will break your distro.

#### MPR, MPR helper and wine repos
```sh
wget -qO - 'https://proget.hunterwittenborn.com/debian-feeds/makedeb.pub' | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/makedeb-archive-keyring.gpg &> /dev/null && echo 'deb [signed-by=/usr/share/keyrings/makedeb-archive-keyring.gpg arch=all] https://proget.hunterwittenborn.com/ makedeb main' | \
sudo tee /etc/apt/sources.list.d/makedeb.list && sudo apt update && sudo apt install makedeb git && git clone https://mpr.hunterwittenborn.com/una-bin.git && cd una-bin && makedeb -si
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
```

#### core packages
```sh
git clone https://mpr.makedeb.org/dwarfs-bin.git && cd dwarfs-bin && makedeb -si
sudo apt install fuse-overlayfs winehq-staging
```

#### graphics packages
```sh
Vulkan universal drivers
sudo apt install libvulkan1 vulkan-tools
sudo apt remove amdvlk

NVIDIA drivers
sudo add-apt-repository ppa:oibaf/graphics-drivers
sudo apt install nvidia-driver-510 nvidia-settings libvulkan1 vulkan-tools

Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.
```

#### various libraries required by some games
```sh
sudo dpkg --add-architecture i386
sudo apt install libva2 giflib-tools libgphoto2-6 libxcrypt-source libva2:i386 alsa-utils:i386 libopenal1:i386 libpulse0:i386 gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-vaapi gstreamer1.0-libav
```
