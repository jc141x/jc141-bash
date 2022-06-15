<div align="center">
  <img src="https://i.postimg.cc/tC3VR1vD/jc141v4.png">
</div>

<div align="center">
  <h1>Setup Guide - General</h1>
</div>

- Support for SteamDeck is work in progress. Documented [here](steamdeck.md). SteamDeck testers needed.

## Not supported:
   - NTFS, because the very different attrs system.
   - LTS distros (Ubuntu LTS, Mint, etc.), because outdated dependencies are hard to support.
   - Immutable os (SteamOS, Fedora Silverblue), because dependencies are hard to install.
   - Third party programs which override config (Lutris).

## Supported distros and their list of required packages

### [Arch](arch.md) (EndeavourOS (recommended), Arco, Artix, Manjaro etc.)
### [Debian Sid](debiansid.md) (Sparky Rolling, Siduction, Nitrux)
### [openSUSE Tumbleweed](opensuse.md)
### [Fedora](fedora.md) (and Rawhide)


## How to extract the archives

### dwarfs archives:
  
- Most of them don't to be extracted, you can play as provided by running the start script.

- Games that run badly mounted, mostly open worlds are automatically extracted at first run.

### zpaq archives:
```sh
cd "path to archive"
zpaq x Game.zpaq
``` 

## How to run the games

```sh
cd "path to extracted game"
bash wstart.sh or however the script is named.
```
- Available variables are: (added before bash)
```sh
DBG=1 - for enabling output from the game binary.

GAMESCOPE=0 - for disabling gamescope.

WINEESYNC=0 WINEFSYNC=0 - for disabling fsync and esync.

FSR=mode - Universal support for FSR through Gamescope 
- Supported modes: ultra, quality, balanced, performance
- Requires rres to be installed, currently supported on Arch and Debian Sid setup pages.

prime-run - for using Nvidia.
  ```
## Available commands for dwarfsettings.sh
```sh
bash dwarfsettings.sh extract
extracts groot.dwarfs to groot directory.

bash dwarfsettings.sh force-unmount
umounts groot-mnt

bash dwarfsettings.sh mount
mounts groot.dwarfs to groot-mnt
```

- You can also use [Rum](https://johncena141.eu.org:8141/johncena141/rum) for creating your own game library.
