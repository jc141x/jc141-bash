<h1>jc141 setup guide</h1>

### not supported
   - NTFS, because the very different attrs system.
   - LTS distros (Ubuntu LTS, Mint, etc.), because outdated dependencies are hard to support.
   - Immutable os (SteamOS, Fedora Silverblue), because dependencies are hard to install.
   - Third party programs which override config (Lutris).

### supported distros

- Support for SteamDeck is work in progress. Documented [here](steamdeck.md). SteamDeck testers who are open to try other distros are needed.

#### [Arch](arch.md)
 - or: EndeavourOS (recommended), Arco, Artix, Manjaro etc.
#### [Debian Sid](debiansid.md)
 - or: Sparky Rolling, Siduction, Nitrux
#### [Fedora](fedora.md)
#### [openSUSE Tumbleweed](opensuse.md)

#### running

```sh
cd "path to extracted game"
bash start.w.sh or however the script is named.

Available variables are: (added before bash)

DBG=1 - for enabling output from the game binary.

GAMESCOPE=0 - for disabling gamescope.

WINEESYNC=0 WINEFSYNC=0 - for disabling fsync and esync.

prime-run - for using Nvidia.
  ```
#### dwarfsettings.sh commands
```sh
bash dwarfsettings.sh extract-game
extracts groot.dwarfs to groot directory.

bash dwarfsettings.sh unmount-game
unmounts groot

bash dwarfsettings.sh mount-game
mounts groot.dwarfs to groot-mnt and overlayfs to groot

bash dwarfsettings.sh mount-prefix
mounts prefix.dwarfs to prefix-mnt and overlayfs to prefix-tmp

bash dwarfsettings.sh unmount-prefix
unmounts prefix.dwarfs from prefix-mnt and overlayfs to prefix-tmp
```
