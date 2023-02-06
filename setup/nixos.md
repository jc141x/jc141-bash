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
