<h3>Setup Guide - Fedora</h3>

#### dwarfs and fuse-overlayfs
Dwarfs isn't available in the repos and copr, so our temporarily solution is this rpm we made.
```sh
wget -qO ~/Downloads/dwarfs-0.6.1-1.fc36.x86_64.rpm https://github.com/jc141x/jc141-bash/releases/download/420/dwarfs-0.6.1-1.fc36.x86_64.rpm && sudo dnf install ~/Downloads/dwarfs-0.6.1-1.fc36.x86_64.rpm
sudo dnf install fuse-overlayfs
```

#### aria2
```sh
sudo dnf install aria2
```

#### graphics packages

```sh
# Universal (AMD/Intel/Nvidia)
sudo dnf install vulkan vulkan-loader

# NVIDIA specific
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install xorg-x11-drv-nvidia akmod-nvidia

Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.
```

#### gamescope
```sh
sudo dnf install gamescope
```
- Gamescope not supported on Nvidia yet, but coming soon. Meanwhile don't install it or it will get used and fail to boot games.

- Technically optional, highly recommended against alt-tab freezes and isolation from system display server.

#### wine-mono
```sh
sudo dnf install wine-mono
```

#### other libraries
```sh
sudo dnf install jq libxcrypt zlib
```

#### audio drivers
```sh
sudo dnf install alsa-lib alsa-plugins fluidsynth pulseaudio openal
```

#### optional packages

##### yuzu
```sh
export API_URL="https://api.github.com/repos/yuzu-emu/yuzu-mainline/releases/latest" && export DOWNLOAD_URL=$(curl -s $API_URL | grep -oP '"browser_download_url": "\K(.*AppImage)(?=")') && curl -Lo /tmp/yuzu --progress-meter $DOWNLOAD_URL && chmod +x /tmp/yuzu && sudo mv /tmp/yuzu /usr/local/bin/yuzu
```
