## Setup Guide - NixOS

### Switch to the Unstable Repo (to have up to date dwarfs package)

```
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
```

### Core packages

Add the following Nix code to your NixOS Configuration, usually located in /etc/nixos/configuration.nix

```sh
environment.systemPackages = [
  pkgs.dwarfs
  pkgs.wine-staging
  pkgs.fuse-overlayfs
  pkgs.gst-libav
  pkgs.gst-plugins-bad1
  pkgs.gst-plugins-base1
  pkgs.gst-plugins-good1
  pkgs.gst-plugins-ugly1
  pkgs.gstreamer-vaapi
];
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

If your dedicated GPU is Nvidia then run the following command when starting the game:

```
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia  __VK_LAYER_NV_optimus=NVIDIA_only VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json bash start-script.sh
```

- We cannot provide a way to make this by default on system due to it breaking other software that runs better with integrated graphics. (due to the proprietary driver)
