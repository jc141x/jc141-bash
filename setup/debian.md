## Setup Guide - Debian Rolling/Sid

- Also applies to Sparky Rolling, Siduction, Nitrux which are rolling by default.

#### Switch to the Rolling/Sid repo for an optimal and up to date experience.
Note: Debian Stable repo is no longer compatible with latest DXVK, thus it is not supported.
#### ONLY FOR DEBIAN STABLE OR TESTING DO NOT USE IT ON KALI OR OTHER MODIFIED DEBIAN BASED DISTRO
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
<br>

#### MPR, MPR helper and wine repos
```sh
sudo dpkg --add-architecture i386
export MAKEDEB_RELEASE='makedeb'
bash -c "$(wget -qO - 'https://shlink.makedeb.org/install')" && sudo apt update && sudo apt install git && git clone https://mpr.hunterwittenborn.com/una-bin.git && cd una-bin && makedeb -si
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources
```
<br>

#### Core packages
```sh
git clone https://mpr.makedeb.org/dwarfs-bin.git && cd dwarfs-bin && makedeb -si
sudo apt install fuse-overlayfs winehq-staging
```
<br>

#### Graphics packages
```sh
Vulkan drivers (AMD/INTEL/NVIDIA)
sudo apt install libvulkan1 vulkan-tools
```
```sh
NVIDIA drivers
sudo wget -O- https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/3bf863cc.pub | gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg

echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list

sudo apt update && sudo apt upgrade -y

sudo apt install nvidia-driver nvidia-settings nvidia-smi nvidia-xconfig nvidia-opencl-icd nvidia-opencl-common nvidia-detect linux-image-amd64 linux-headers-amd64
```
<br>

#### Configuring Hybrid setups (most likely laptops).

A hybrid setup is one where both an integrated GPU and a dedicated one are ready to be used by the system. GNU/Linux will generally default to using the integrated GPU unless told otherwise. (which is not good for performance)

The commands below will make the dedicated GPU the default when running commands such as the start scripts.

If your dedicated GPU is Radeon then run the following command:

```
echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' | sudo tee -a /etc/environment
```

If your dedicated GPU is Nvidia then run the following command:

```
echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json' | sudo tee -a /etc/environment
```
<br>

#### Various libraries required by some games
```sh
sudo apt install libva2 giflib-tools libgphoto2-6 libxcrypt-source libva2:i386 alsa-utils:i386 libopenal1:i386 libpulse0:i386 gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-vaapi gstreamer1.0-libav gstreamer1.0-plugins-good:i386 gstreamer1.0-plugins-base:i386
```
<br>

#### Optional - Security features

Enables start scripts to block WAN activity.

```
una install bindtointerface lib32-bindtointerface && sudo apt install
```
