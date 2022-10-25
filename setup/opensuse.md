<h3>Setup Guide - OpenSUSE Tumbleweed</h3>

#### dwarfs, also available in nix package manager

```sh
sudo zypper ar https://copr.fedorainfracloud.org/coprs/jc141/DwarFS/repo/epel-9/jc141-DwarFS-epel-9.repo
sudo zypper refresh
sudo zypper install dwarfs
# Solution 2: break dwarfs-0.6.1-1.el9.x86_64 by ignoring some of its dependencies
# Do you want to reject the key, or trust always? [r/a/?] (r): a
```

#### fuse-overlayfs

```sh
sudo zypper install fuse-overlayfs
```

#### AMD graphics packages

```sh
sudo zypper install libvulkan_radeon libvulkan_radeon-32bit libvulkan1 vulkan-tools
```

#### INTEL graphics packages

```sh
sudo zypper install libvulkan_intel libvulkan_intel-32bit libvulkan1 vulkan-tools
```

#### NVIDIA graphics packages

```sh
sudo zypper install libglvnd-32bit libglvnd libvulkan1 vulkan-tools
```

- Add `nvidia-drm.modeset=1` as a kernel parameter for the best results.

#### wine-staging + wine-mono

```sh
sudo zypper install wine-staging wine-mono
```

#### various libraries required by some games

```sh
sudo zypper install giflib-devel-32bit libXcomposite-devel-32bit libXinerama-devel-32bit libxslt-devel-32bit mpg123-devel-32bit mpg123-openal-32bit zlib-devel-32bit libpulse-devel-32bit giflib-devel libgphoto2-6 zlib-devel libva2 gstreamer-plugins-base gstreamer-plugins-good gstreamer-plugins-ugly gstreamer-plugins-bad gstreamer-plugins-vaapi gstreamer-plugins-libav
```

-------------------------------------------------------------------------------------------------------------------

### optional packages

#### gamescope
Isolates game from system display server, no desktop res changing when in use. As well as forcing games into fullscreen and scaling when necessary. Can provide AMD FidelityFX Super Resolution or NVIDIA Image Scaling support.

```sh
sudo zypper install opi
#when running opi, install from home:VortexAcherontic:Nightly
opi gamescope
```

- NVIDIA drivers may have some issues with this.
- Requires **full** Vulkan support. (old architectures with none or semi are not compatible)
- May cause failure to run from first try in certain cases.
- Is not always used by scripts, testing is done to confirm that it is compatible.
