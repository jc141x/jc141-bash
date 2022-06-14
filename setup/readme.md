<div align="center">
  <img src="https://i.postimg.cc/NfxWWvdN/jc141.png">
</div>

<div align="center">
  <h1>Setup Guide - General</h1>
</div>

## Not supported:
   - NTFS, because the very different attrs system.
   - LTS distros (Ubuntu LTS, Mint, etc.), because outdated dependencies are hard to support.
   - Immutable os (SteamOS, Fedora Silverblue), because dependencies are hard to install
   - Third party programs which override config (Lutris).

## Supported distros and their list of required packages

### [Arch](https://johncena141.eu.org:8141/johncena141/jc141-bash/src/branch/main/setup/arch.md) (EndeavourOS (recommended), Arco, Artix, Manjaro etc.)
### [Debian Sid](https://johncena141.eu.org:8141/johncena141/jc141-bash/src/branch/main/setup/debiansid.md) (Sparky Rolling, Siduction, Nitrux)
### [openSUSE Tumbleweed](https://johncena141.eu.org:8141/johncena141/jc141-bash/src/branch/main/setup/opensuse.md)
### [Fedora](https://johncena141.eu.org:8141/johncena141/jc141-bash/src/branch/main/setup/fedora.md) (and Rawhide)


## How to extract the archives

### dwarfs archives:
  
- They don't need to be extracted, you can play as provided by running the start script.

- However, we do support extracting it for hardware that has very low reading speed like 12 year old laptops.

```
bash dwarfsettings.sh extract
```

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

- You can also use [Rum](https://johncena141.eu.org:8141/johncena141/rum) for creating your own game library.

---
 
- Support for SteamDeck is work in progress. Documented [here](https://johncena141.eu.org:8141/silentnoodlemaster/steamdeck)