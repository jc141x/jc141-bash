## Setup Guide - Arch Linux

*Note* - Arch Linux is rolling release and to keep it working properly a full update needs to be conducted regularly.

This guide will allow you to set up our releases on an Arch Linux based set up. Other GNU/Linux distributions that can use this guide include the following:

- EndeavourOS (recommended easy installer and preconfiguration for Arch)
- Artix
- ArcoLinux
- Manjaro
- Other Arch Linux based distributions
<br>

### Pacman configuration

Copy and paste the following commands into your terminal, you may need to use `Ctrl + Shift + V` to paste.

  1. Add the rumpowered repository

     ```sh
     echo '
     [rumpowered]
     Server = https://jc141x.github.io/rumpowered-packages/$arch ' | sudo tee -a /etc/pacman.conf
     ```
  2. Add the multilib packages

     ```sh
     sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
     ```
  3. Add and locally sign the keys for the repository

     ```sh
     sudo pacman-key --recv-keys cc7a2968b28a04b3
     ```

     ```sh
     sudo pacman-key --lsign-key cc7a2968b28a04b3
     ```
  4. Force refresh all packages (even if in-date) and update

     ```sh
     sudo pacman -Syyu
     ```
<br>

### Add required core packages

These packages are all required for our releases to work, if you don't have them the games will not run.

```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono
```
<br>

### Add graphics packages for your set up.

Check whether your graphics card is AMD, INTEL or NVIDIA then follow the associated instructions below. Paste them into your terminal. You will need to follow the instructions for the Vulkan Drivers and one of the GPU instructions.

- GPU/APU Drivers required for AMD GPUs

    ```sh
    sudo pacman -S --needed lib32-vulkan-radeon vulkan-radeon lib32-vulkan-icd-loader
    ```
    - *Note*: For AMD GPUs please ensure that you do not have installed improper drivers with `sudo pacman -R amdvlk && sudo pacman -R vulkan-amdgpu-pro`. This software breaks the proper driver.

- GPU/APU Drivers required for INTEL GPUs

    ```sh
    sudo pacman -S --needed lib32-vulkan-intel vulkan-intel lib32-vulkan-icd-loader
    ```
- GPU Drivers required for NVIDIA GPUs

    ```sh
    sudo pacman -S --needed lib32-libglvnd lib32-nvidia-utils libglvnd nvidia lib32-vulkan-icd-loader
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

### Install additional libraries

Some games require additional libaries to run successfully. We strongly recommend the following libraries are installed.

```sh
sudo pacman -S --needed lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal libgphoto2 libxcrypt-compat gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-plugins-base-libs lib32-gst-plugins-base lib32-gst-plugins-good
```
<br>

### Optional - Security features

Enables start scripts to block WAN activity.

```
sudo pacman -S --needed rumpowered/bindtointerface rumpowered/lib32-bindtointerface
```
