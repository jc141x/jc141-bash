## jc141 Setup Guide

Haven't installed GNU/Linux yet or seek a recommendation? check out [EndeavourOS](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/).

This is a 4 step setup guide which takes a few moments to follow with streamlined commands for installation of required components.

In return for this extended involvment for your part towards running our releases you get a number of useful features.

- Running releases without extracting them through the use of DwarFS.
- Blocking WAN activity through the use of bindToInterface. (optional)
- A highly flexible use of scripting which enables users to achieve a lot of wishes such as: recreating dwarfs files, using own compilation/custom versions of software since we rely on packages instead of static linking and some other options available.

<br><br>

### Supported GNU/Linux Distributions

*   Arch including: Endeavour OS, Arco, Artix, Manjaro, etc.
*   Debian Sid/Rolling including: Sparky Rolling, Siduction and Mint/LMDE, etc.
*   NixOS
<br><br>

### Hardware Support
Vulkan support is required unless the start script is named start.n.sh. And even then there are some games which require it.

#### [SteamDeck support on Arch](steamdeck.md)

- If you are on SteamDeck, follow instructions here first then come back to the main setup guide.

<br><br><br><br>


## 1. Pre-configuration

#### Arch

Copy and paste the following commands into your terminal.

1. Add the rumpowered repository.

```sh
echo '
[rumpowered]
Server = https://jc141x.github.io/rumpowered-packages/$arch ' | sudo tee -a /etc/pacman.conf
```
2. Add the multilib repo and sign keys for rumpowered.

```sh
sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
sudo pacman-key --recv-keys cc7a2968b28a04b3
sudo pacman-key --lsign-key cc7a2968b28a04b3
```

3. **Manjaro only**. Switch to unstable branch.

```sh
sudo pacman-mirrors --api --set-branch unstable && sudo pacman-mirrors --fasttrack 5
```

4. Force refresh all packages (even if in-date) and update.

```sh
sudo pacman -Syyu
```

-------------------------------------

#### Debian

- Switch to the Rolling/Sid repo for an optimal and up to date experience. Not necessary on Sparky Rolling, Siduction, Nitrux.

#### ONLY FOR DEBIAN STABLE OR TESTING DO NOT USE IT ON KALI OR OTHER MODIFIED DEBIAN BASED DISTRO

```sh
1. Edit /etc/apt/sources.list:
sudo nano /etc/apt/sources.list

2. Edit sources.list to only use these repos:

deb http://deb.debian.org/debian/ sid main contrib non-free
deb-src http://deb.debian.org/debian/ sid main

3. Save the file and update your system to Sid (This will reboot your system):

sudo apt update && sudo apt full-upgrade && sudo reboot
```
- Optionally you can install `apt-listbugs apt-listchanges` to read the bugs and see if any of them will break your distro.
<br>

##### MPR and wine repos
```sh
sudo dpkg --add-architecture i386
export MAKEDEB_RELEASE='makedeb'
bash -c "$(wget -qO - 'https://shlink.makedeb.org/install')" && sudo apt update && sudo apt install git && git clone https://mpr.hunterwittenborn.com/una-bin.git && cd una-bin && makedeb -si
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources
```

-------------------------------------

#### NixOS

- Switch to the Unstable Repo. (to have up to date dwarfs package)

```
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
```

<br><br>

## 2. Install required packages

#### Arch based

```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging bubblewrap wine-mono lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-pipewire lib32-openal libgphoto2 libxcrypt-compat gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-plugins-base-libs lib32-gst-plugins-base lib32-gst-plugins-good rumpowered/bindtointerface rumpowered/lib32-bindtointerface sdl2_ttf sdl2_image
```

-------------------------------------

#### Debian based

```
git clone https://mpr.makedeb.org/dwarfs-bin.git && cd dwarfs-bin && makedeb -si
sudo apt install fuse-overlayfs winehq-staging bubblewrap libva2 giflib-tools libgphoto2-6 libxcrypt-source libva2:i386 alsa-utils:i386 libopenal1:i386 libpulse0:i386 gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-vaapi gstreamer1.0-libav gstreamer1.0-plugins-good:i386 gstreamer1.0-plugins-base:i386 && una install bindtointerface lib32-bindtointerface
```

-------------------------------------

#### NixOS based

Add the following Nix code to your NixOS Configuration, usually located in /etc/nixos/configuration.nix .

```sh
environment.systemPackages = [
  pkgs.dwarfs
  pkgs.wine-staging
  pkgs.fuse-overlayfs
  pkgs.bubblewrap
  pkgs.gst-libav
  pkgs.gst-plugins-bad1
  pkgs.gst-plugins-base1
  pkgs.gst-plugins-good1
  pkgs.gst-plugins-ugly1
  pkgs.gstreamer-vaapi
];
```

<br><br>

## 3. Install graphics packages

### AMD APU/GPUs

#### Arch based

```sh
sudo pacman -S --needed lib32-vulkan-radeon vulkan-radeon lib32-vulkan-icd-loader
```
- *Note*: For AMD GPUs please ensure that you do not have installed improper drivers with `sudo pacman -R amdvlk && sudo pacman -R vulkan-amdgpu-pro`. This software breaks the proper driver.

-------------------------------------

#### Debian based

```sh
sudo apt install libvulkan1 libvulkan1:i386 vulkan-tools
```

-------------------------------------

#### NixOS based

[Follow NixOS Wiki](https://nixos.wiki/wiki/AMD_GPU)

<br><br>

### INTEL APU/GPUs

#### Arch based

```sh
sudo pacman -S --needed lib32-vulkan-intel vulkan-intel lib32-vulkan-icd-loader
```

-------------------------------------

#### Debian based

```sh
sudo apt install libvulkan1 libvulkan1:i386 vulkan-tools
```

-------------------------------------

#### NixOS based

[Follow NixOS Wiki](https://nixos.wiki/wiki/Intel_Graphics) - Page does not provide information about enabling Vulkan, follow Radeon page instead for that part.

<br><br>

### NVIDIA GPUs

- Warning: Some pacakges are proprietary, for now...

#### Arch based

```sh
sudo pacman -S --needed lib32-libglvnd lib32-nvidia-utils libglvnd nvidia lib32-vulkan-icd-loader
```

-------------------------------------

#### Debian based

```sh
sudo wget -O- https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/3bf863cc.pub | gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg

echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list

sudo apt update && sudo apt upgrade -y

sudo apt install nvidia-driver nvidia-settings nvidia-smi nvidia-xconfig nvidia-opencl-icd nvidia-opencl-common nvidia-detect linux-image-amd64 linux-headers-amd64 libvulkan1 libvulkan1:i386 vulkan-tools
```

-------------------------------------

#### NixOS based

[Follow NixOS Wiki](https://nixos.wiki/wiki/Nvidia)

<br><br><br>


### 4. Run the games
Open up a terminal and then run the following command. Please edit where appropriate.

ATTENTION! - Using sh instead of bash does not work!  Only use bash or ./ with x permission.

```
bash /Path/to/Game/start.{n/e-w/n-w}.sh
```

<br><br><br>

### Optional actions

#### Available environment variables

- They need to be added before the bash command or they are not taken into effect.
```
CACHEPERCENT=15 - Percentage of total hardware RAM to be used by dwarfs as cache. Higher means better smoothness.

DBG=1 - Enables terminal output of binary and/or wine.

WANBLK=0 - Disables WAN blocking which is enabled by default if bindtointerface package is installed.

UNMOUNT=0 - Disables auto-unmounting of the dwarfs image from 'files/groot'.

ISOLATION=0 - Disabled bubblewrap filesystem isolation and networking blocking.

__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia  __VK_LAYER_NV_optimus=NVIDIA_only VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json - Forces Nvidia to be used by default instead of integrated graphics.
```

-------------------------------------

#### Dwarfs Actions
settings.sh file provides some optional commands which can be useful.

```
bash settings.sh COMMAND

Available Commands
  extract
  unmount
  mount
  delete-image
  compress
  check-integrity
```
The extraction command will automatically make start script use the extracted files and will not attempt to run mounted again until groot directory is missing/empty again (if the script defaults to mounting).

-------------------------------------

#### Modding/Updating
In order to add files or edit the existing game files, you need to mount the game files with `bash settings.sh mount`.

Then you will have read-write access to the files/groot directory. Anything that you add or modify will not be saved into the dwarfs image which is read-only but instead be saved into the files/overlay-storage directory.

Any data existing in this directory will override the game files when the mounting command is run. The start script runs the mounting command on each run.

<br>

Overriding means the modified/added files are shown to the system and the original ones are hidden. Even though they continue to exist in the dwarfs image.

<br>

This point does not only work for modding but also for updating the files. However if the update is big then a lot of files will be duplicated to the files/overlay-storage directory. Another option is to extract the files with `bash settings.sh extract`, run the update on them, delete or rename the dwarfs image and run `bash settings.sh compress`.

-------------------------------------

#### Dwarfs Image Recreation

This is a pretty particular quirky yet interesting thing you can do. Take this as an example: You download our release of a pretty big in size game and it is version 1.5. We release version 1.6 but it is standalone. You want to seed our current release but this means you would need to redownload the release. Well not quite. You can also re-create the dwarfs image we made by using a third party for the updated files and then compressing the files yourself.

This alone would not enable you to create a similar or identical dwarfs image. However, we have implemented some automatization for this use case. Recent releases include in the files directory a text file called dwarfs-tree.txt where you can see the listing of all the files included in the dwarfs image. In the block-lvl.txt there will be some values for the compression settings which vary depending on the release. These values are automatically used by the command `bash settings.sh compress` if the file is present.

So step 1:

Extract game files with `bash settings.sh extract`

Step 2: Update the game files with a trusted third party. Compare the resulted files to the dwarfs-tree.txt file and delete extra files we considered pointless, if any.

Step 3: Rename/delete the original dwarfs image and run `bash settings.sh compress`

Step 4: You have an identical or at worst very similar dwarfs image comparing to our release. Not being identical is not a deal breaker though. You can add the new torrent release from us to the torrent client which would then download the rest of the data it did not find. This data is likely to be a very small percentage of the size given the previous measures we took for similarity.

Step 5: Rename/delete the groot directory in order to have the game mount again by default instead of running the extracted files.

#### GUI Libary
If you would like a GUI library for your games, see [launchers](launchers.md) page.
