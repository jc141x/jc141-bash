## jc141 Setup Guide

Haven't installed GNU/Linux yet or seek a recommendation? check out [EndeavourOS](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/).

Suggestions for any changes to this repo are welcome on [Matrix](https://matrix.to/#/%21aRyMmzPUzcUKRXpVtP%3Amatrix.org?via=catgirl.cloud&via=grin.hu&via=matrix.org).

Virtual Machines are not supported.
<br>

### Supported GNU/Linux Distributions
Please click one the following links to setup your GNU/Linux distribution.

*   [Arch](arch.md) including: Endeavour OS, Arco, Artix, Manjaro and others.
*   [Debian Sid/Rolling](debian.md) including: Nitrux, Sparky Rolling, Siduction and Mint/LMDE.
*   [NixOS](nixos.md)
<br>

### Hardware Support
Releases with start.e-w.sh must have Vulkan 1.3 support.

Releases with start.n-w.sh require Vulkan support but not 1.3 necessarily. 

Releases with start.n.sh generally do not require vulkan support.

#### [SteamDeck support on Arch](steamdeck/arch.md)
<br>

### How to Run the Game
Open up a terminal and then run the following command. Please edit where appropriate.

ATTENTION! - Using sh instead of bash does not work!  Only use bash or ./ with x permission.

```
bash /Path/to/Game/start.{n/e-w/n-w}.sh
```

Available environment variables: (all environment variables need to be added before the bash command, or they are not taken into effect)
```
CACHEPERCENT=15 - Percentage of total hardware RAM to be used by dwarfs as cache. Higher means better smoothness.

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

### Modding/Updating
In order to add files or edit the existing game files, you need to mount them with `bash settings.sh mount`.

Then you will have read-write access to the files/groot directory. Anything that you add or modify will not be saved into the dwarfs image which is read-only but instead be saved into the files/groot-rw directory.

Any data existing in this directory will override the game files when the mounting command is run. So also when you run the start script which does just that.

Overriding means the modified/added files are shown to the game and the original ones are hidden. Even though they continue to exist in the dwarfs image.


This point does not only work for modding but also for updating the files. However if the update is big then a lot of files will be duplicated to the files/groot-rw directory. Another option is to extract the files with `bash settings.sh extract`, run the update on them, delete or rename the dwarfs image and run `bash settings.sh compress`.
<br><br>

### Additional Information
All releases are tested on Arch Linux or EndeavourOS using either EXT4, BTRFS or XFS filesystems.
<br><br>

### GUI Libary
If you would like a GUI library for your games, see [launchers](launchers.md) page.
