## Setup Guide - NixOS

### Core packages
```sh
sudo nix-shell -p dwarfs wine-staging fuse-overlayfs
```

### Drivers
- Vulkan Drivers required by AMD/INTEL/NVIDIA.

Follow the NixOS Wiki for your graphic unit:
- [Nvidia](https://nixos.wiki/wiki/Nvidia)
- [Radeon/AMD](https://nixos.wiki/wiki/AMD_GPU)
- [Intel](https://nixos.wiki/wiki/Intel_Graphics)
   - Intel page does not provide information about enabling Vulkan, follow Radeon page instead for that part.

### Install additional libraries

Some games require additional libaries to run successfully. We strongly recommend the following libraries are installed.

```sh
sudo nix-shell gst-libav gst-plugins-bad1 gst-plugins-base1 gst-plugins-good1 gst-plugins-ugly1 gstreamer-vaapi
```
