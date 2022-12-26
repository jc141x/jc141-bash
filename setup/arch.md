## Setup Guide - Arch Linux

This guide will allow you to set up our releases on an Arch Linux based set up. Other GNU/Linux distributions that can use this guide include the following:

* EndeavourOS
* Artix
* ArcoLinux
* Manjaro
* Other Arch Linux based distributions

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
3. Add and the keys for the repository

    ```sh
    sudo pacman-key --recv-keys cc7a2968b28a04b3
    ```

    ```sh
    sudo pacman-key --lsign-key cc7a2968b28a04b3
    ```
4. Force refresh (even if apparently in date) all packages and update

    ```sh
    sudo pacman -Syyu
    ```

### Step 2: Add required core packages
These packages are all required for our releases to work, if you don't have them the games will not run.

```sh
sudo pacman -Syu --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono openssl-1.1
```

### Step 3: Add graphics packages for your set up.
Check whether your graphics card is AMD, INTEL or NVIDIA then follow the associated instructions below. Paste them into your terminal.

- Vulkan Drivers required by AMD/INTEL/NVIDIA

    ```sh
    sudo pacman -S --needed lib32-vulkan-icd-loader vulkan-icd-loader 
    ```
- GPU Drivers for AMD GPUs

    ```sh
    sudo pacman -S --needed lib32-vulkan-radeon vulkan-radeon
    ```
    - *Note*: For AMD GPUs please ensure you remove amdvlk with `sudo pacman -R amdvlk`. This software conflicts with our releases.

- GPU Drivers for INTEL GPUs

    ```sh
    sudo pacman -S --needed lib32-vulkan-intel vulkan-intel
    ```
- GPU Drivers for NVIDIA GPUs

    ```sh
    sudo pacman -S --needed lib32-libglvnd lib32-nvidia-utils libglvnd nvidia
    ```

- AMD: Make sure you do not have amdvlk with `sudo pacman -R amdvlk`. Having it installed will cause a lot of issues.
- NVIDIA: Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.

### various libraries required by some games

```sh
sudo pacman -S --needed lib32-giflib lib32-gnutls lib32-libxcomposite lib32-libxinerama lib32-libxslt lib32-mpg123 lib32-v4l-utils lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib giflib libgphoto2 libxcrypt-compat zlib gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav
```

### OPTIONAL - bindtointerface - block non-LAN network activity by default
```
sudo pacman -S --needed rumpowered/bindtointerface
```

### other notes

The arch system is supposed to be kept up to date and the releases also use software that requires latest drivers. Update your system at least weekly with:
```sh
sudo pacman -Syu
```
