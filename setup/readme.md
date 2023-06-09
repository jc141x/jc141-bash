## jc141 Setup Guide

Haven't installed GNU/Linux yet or seek a recommendation? check out [EndeavourOS](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/).

Suggestions for any changes to this repo are welcome on [Matrix](https://matrix.to/#/%21aRyMmzPUzcUKRXpVtP%3Amatrix.org?via=catgirl.cloud&via=grin.hu&via=matrix.org).

Virtual Machines are not supported.
<br>

### Supported GNU/Linux Distributions
Please click the following links to setup your GNU/Linux distribution.

*   [Arch](arch.md) including: Endeavour OS, Arco, Artix, Manjaro and others.
*   [Debian Sid/Rolling](debian.md) including: Nitrux, Sparky Rolling and Siduction.
*   [Fedora](fedora.md) including: Rawhide.
*   [NixOS](nixos.md)
*   [OpenSUSE Tumbleweed](opensuse.md)
*   [Ubuntu](ubuntu-based.md) including: Mint and others based on it.
<br>

### Hardware Support
You graphic hardware (GPU/APU) **must** have Vulkan 1.3 support for releases which use DXVK and VKD3D, marked as start.e-w.sh for the start script.

Releases with start.n-w.sh require Vulkan support but not 1.3 necessarily. Releases with start.n.sh generally do not require vulkan support.

#### [SteamDeck support on Arch](steamdeck/arch.md)
<br>

### How to Run the Game
Open up a terminal and then run the following command. Please edit where appropriate.

ATTENTION! - Using sh instead of bash does not work!  Only use bash or ./ with x permission.

```
bash /Path/to/Game/start.{n/e-w/n-w}.sh
```

Available environment variables:
```
CACHEPERCENT=15 - Percentage of total hardware RAM to be used by dwarfs as cache. Higher means better smoothness (not necessarily impactful if increased further). 15% is default.

DBG=1 - Enables terminal output of binary and/or wine.

WANBLK=0 - Disables WAN blocking which is enabled by default if bindtointerface package is installed.

UNMOUNT=0 - Disables auto-unmounting of the dwarfs image from 'files/groot'.
```
<br>

### Dwarfs
settings.sh file provides some optional commands which can be useful.

```
bash settings.sh COMMAND

Available Commands (older version)
  extract (extract-dwarfs)
  unmount (unmount-dwarfs)
  mount (mount-dwarfs)
  delete-image (delete-dwarfs)
  compress (compress-dwarfs)
```
The extraction command will automatically make start script use the extracted files and will not attempt to run mounted again until groot directory is missing/empty again (if the script defaults to mounting).
<br><br>

### Modding
Adding a mod is supported through using the `files/groot-rw` directory. Add files to it directly or mount the game files as seen above and add or edit files in the 'files/groot' directory.

These files will be saved into the 'files/groot-rw' directory and override the base game files on each run.
<br><br>

### Additional Information
All releases are tested on Arch Linux or EndeavourOS using either EXT4, BTRFS or XFS filesystems.
<br><br>

### GUI Libary
If you would like a GUI library for your games, see [launchers](launchers.md) page.
