## Setup Guide - Arch Linux

This guide will allow you to set up our releases on an Arch Linux based set up. Other GNU/Linux distributions that can use this guide include the following:

- EndeavourOS (recommended easy installer and preconfiguration for Arch)
- Artix
- ArcoLinux
- Manjaro
- Other Arch Linux based distributions

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

### Step 2: Add required core packages

These packages are all required for our releases to work, if you don't have them the games will not run.

```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono openssl-1.1
```

### Step 3: Add graphics packages for your set up.

Check whether your graphics card is AMD, INTEL or NVIDIA then follow the associated instructions below. Paste them into your terminal. You will need to follow the instructions for the Vulkan Drivers and one of the GPU instructions.

- Vulkan Drivers required by AMD/INTEL/NVIDIA

    ```sh
    sudo pacman -S --needed vulkan-icd-loader 
    ```
- GPU/APU Drivers required for AMD GPUs

    ```sh
    sudo pacman -S --needed vulkan-radeon
    ```
    - *Note*: For AMD GPUs please ensure that you do not have installed improper drivers with `sudo pacman -R amdvlk && sudo pacman -R vulkan-amdgpu-pro`. This software breaks the proper driver.

- GPU/APU Drivers required for INTEL GPUs

    ```sh
    sudo pacman -S --needed vulkan-intel
    ```
- GPU Drivers required for NVIDIA GPUs

    ```sh
    sudo pacman -S --needed lib32-libglvnd lib32-nvidia-utils libglvnd nvidia
    ```
    
### Step 4: Install additional libraries

Some games require additional libaries to run successfully. We strongly recommend the following libraries are installed.

```sh
sudo pacman -S --needed lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal giflib libgphoto2 libxcrypt-compat zlib gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav
```

### Step 5: OPTIONAL - Prevent non-LAN activity by default.

It is recommended that you prevent access to the WAN for our releases.

```
sudo pacman -S --needed rumpowered/bindtointerface rumpowered/lib32-bindtointerface
```

### Step 6: Update your system

Arch Linux is rolling release and to keep it working properly a full update needs to be conducted regularly, this will ensure that your system will have the latest drivers and tech/software.

```sh
sudo pacman -Syu
```

If you had a kernel update, please restart your system afterwards.
