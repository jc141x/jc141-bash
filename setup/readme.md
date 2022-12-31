## jc141 Setup Guide

Haven't installed GNU/Linux yet? check out [EndeavourOS](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/).

Suggestions for any changes to this repo are welcome on [Matrix](https://matrix.to/#/%21aRyMmzPUzcUKRXpVtP%3Amatrix.org?via=catgirl.cloud&via=grin.hu&via=matrix.org).

### Supported GNU/Linux Distributions
Please click the following links to take you how to setup on your GNU/Linux distribution.
*Using a supported distro means you can assume the releases will run mostly without issues.

*   [Arch](arch.md) including: Endeavour OS, Arco, Artix, Manjaro and others
*   [Debian](debian.md) including: Nitrux, Sparky Rolling and Siduction
*   [Fedora](fedora.md) including: Rawhide and Silverblue
*   [OpenSUSE Tumbleweed](opensuse.md)

### Hardware Support
*   [SteamDeck support on Arch](steamdeck/arch.md)

Not all hardware will run our releases. Please ensure your hardware meets the following specifications:

* GPU/APU
  *   **Must** have Vulkan 1.3 support. Without it many releases will not run.
   
* CPU
  *   **Should** be at least an Intel i3 or equivalent.   

* RAM
  *   **Should** be at least 8GB.

* HDD/SSD
  *   **Should** be up to modern standards. The Dwarfs mounting system is demanding in some cases.

### How to Run the Game
Open up a terminal and then run the following commands. Please edit where appropriate.

```
bash /Path/to/Game/start.{n/w/e-w/n-w}.sh
```
Please check the script for the exact name, of course you can navigate to the directory and run the command there, negating the `/Path/to/Game`.

#### Troubleshooting
If for whatever you have a problem running the game please consider the following command to help with debugging.

```
DBG=1 bash /Path/to/Game/start.{n/w/e-w/n-w}.sh
```
This will produce output that will help us diagnose the problem. please also ensure you have the `start.{n/we-w/n-w}.sh` to hand.

#### Operating Dwarfs
Should your game exit in an inappropriate fashion or you would like to extract, there are a number of built-in commands to help you.

```
bash settings.sh <COMMAND>

Available Commands
  extract-dwarfs
  unmount-dwarfs
  mount-dwarfs
  delete-dwarfs
  compress-to-dwarfs
```

#### Modding Games with Dwarfs

Modding games with Dwarfs is somewhat different from the normal process, please follow the instructions here if you wish to add mods to your game.

Adding a mod is supported through using the `groot-rw` directory. Before mounting, any files included in it will go above the mounted image and override any of the files. The path required for the mod may need to be created manually.

The `groot-rw` directory only exists after the first run of mounted games. However, the directory can be created manually and content can be added without running.

**Note:** Games which are extracted do not require this method.

#### Additional Information

All releases are tested on an either Arch Linux or EndeavourOS using either an EXT4, BTRFS or XFS filesystem.

Window Managers are known to have more issues related to displaying, including freezing and crashing in rare cases.

#### GUI Libary

If you would like a GUI library for your games, see [launchers](launchers.md) page.
