<img src="https://i.postimg.cc/5yfZCY7b/43534534.png">

<h2>Setup Guide - General</h2>

- Support for SteamDeck is work in progress. Documented [here](steamdeck.md). SteamDeck testers who are open to try other distros are needed.

### Not supported:
   - NTFS, because the very different attrs system.
   - LTS distros (Ubuntu LTS, Mint, etc.), because outdated dependencies are hard to support.
   - Immutable os (SteamOS, Fedora Silverblue), because dependencies are hard to install.
   - Third party programs which override config (Lutris).

### Supported distros and their list of required packages

#### [Arch](arch.md)
 - or: EndeavourOS (recommended), Arco, Artix, Manjaro etc.
#### [Debian Sid](debiansid.md)
 - or: Sparky Rolling, Siduction, Nitrux
#### [Fedora](fedora.md)
 - or: Rawhide
#### [openSUSE Tumbleweed](opensuse.md)

#### dwarfs torrent type:
  
- Most of them don't need to be extracted, you can play as provided by running the start script.

- Games that run badly mounted, mostly open worlds are automatically extracted at first run.

#### How to extract zpaq archives:
```sh
cd "path to archive"
zpaq x Game.zpaq
``` 

### How to run the games

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
### Available commands for dwarfsettings.sh
```sh
bash dwarfsettings.sh extract-game
extracts groot.dwarfs to groot directory.

bash dwarfsettings.sh unmount-game
unmounts groot-mnt

bash dwarfsettings.sh mount-game
mounts groot.dwarfs to groot-mnt and overlayfs to groot

bash dwarfsettings.sh mount-prefix
mounts prefix.dwarfs to prefix-mnt and overlayfs to prefix-tmp

bash dwarfsettings.sh unmount-prefix
unmounts prefix.dwarfs from prefix-mnt and overlayfs to prefix-tmp
```

- You can also use [Rum](https://johncena141.eu.org:8141/johncena141/rum) for creating your own game library.
