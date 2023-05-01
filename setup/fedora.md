<h3>Setup Guide - Fedora</h3>

#### Core packages
```sh
sudo dnf copr enable jc141/DwarFS && sudo dnf install fuse-overlayfs dwarfs wine
```
<br>

#### Graphics packages

```sh
# Universal
sudo dnf install vulkan vulkan-loader

# NVIDIA specific
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install xorg-x11-drv-nvidia akmod-nvidia
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

#### Other libraries
```sh
sudo dnf install libxcrypt alsa-lib alsa-plugins-pulseaudio fluidsynth pulseaudio openal
```
