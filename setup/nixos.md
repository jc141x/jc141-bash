## Setup Guide - NixOS

### Core packages
```sh
sudo nix-shell -p dwarfs wine-staging fuse-overlayfs
```

### Drivers

Follow the NixOS Wiki for your graphic unit:

#### [Nvidia](https://nixos.wiki/wiki/Nvidia)

#### [Radeon/AMD](https://nixos.wiki/wiki/AMD_GPU)

#### [Intel](https://nixos.wiki/wiki/Intel_Graphics) - Page does not provide information about enabling Vulkan, follow Radeon page instead for that part.

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
echo '__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json' | sudo tee -a /etc/environment
```
<br>

### Install additional libraries

Some games require additional libaries to run successfully. We strongly recommend the following libraries are installed.

```sh
sudo nix-shell gst-libav gst-plugins-bad1 gst-plugins-base1 gst-plugins-good1 gst-plugins-ugly1 gstreamer-vaapi
```
