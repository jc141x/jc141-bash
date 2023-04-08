## Setup Guide - NixOS/Void(?)

The guide is in construction and not guaranteed to work.

### core packages
```sh
sudo nix-shell -p dwarfs wine-staging fuse-overlayfs
```

### drivers
- Vulkan Drivers required by AMD/INTEL/NVIDIA

```sh
sudo nix-shell vulkan-tools
```

### Install additional libraries

Some games require additional libaries to run successfully. We strongly recommend the following libraries are installed.

```sh
sudo nix-shell gst-libav gst-plugins-bad1 gst-plugins-base1 gst-plugins-good1 gst-plugins-ugly1 gstreamer-vaapi
```
