# jc141 setup guide</h1>

Haven't installed linux yet? check out [EndeavourOS](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/)

## supported distro packages

### [Arch](arch.md)
 - or: EndeavourOS (recommended), Arco, Artix, Manjaro etc.
 - uploads are tested on Archlinux or EndeavourOS

### [Debian Sid](debiansid.md)
 - or: Sparky Rolling, Siduction, Nitrux
### [Fedora/Rawhide](fedora.md)
### [OpenSUSE Tumbleweed](opensuse.md)

### [SteamDeck Hardware support on Arch](steamdeck.md)

## not supported distros

Releases might work but we can't porimise anything and don't want to waste time troubleshooting, for setup look at what most closely resembles your distro and use common sense. For example, if you use apt as your package manager you go for debian.

   - Debian Stable (outdated)
     - Ubuntu (malware, outdated)
          - Kubuntu, Lubuntu, Xubuntu
          - Mint, Elementary OS, Zorin OS, POP! OS
          - LXLE, KDE Neon 
   - SteamOS (malware, read-only, lack of packages)
   - Fedora Silverblue (read-only)

**Vulkan support is required**

**NTFS not supported**

## running

```sh
cd "path to extracted game"
bash start.w.sh or however the script is named.

Available variables are: (added before bash)

DBG=1 - for enabling terminal output from the game binary and other software ran.

GAMESCOPE=0 - for disabling gamescope.

WINEFSYNC=0 - for disabling fsync.
```

- game can also be ran directly from file manager by right clicking on start.x.sh and giving executable permission.
  - May result in failure to boot sometimes. Best to run from terminal.

### settings.sh commands
```
bash settings.sh extract-dwarfs
extracts groot.dwarfs to groot directory if it is empty

bash settings.sh unmount-dwarfs
unmounts groot

bash settings.sh mount-dwarfs
mounts groot.dwarfs to groot-mnt and overlay to groot

bash settings.sh delete-dwarfs
deletes dwarfs image which contains the game files

bash settings.sh compress-to-dwarfs
compresses extracted game files to groot.dwarfs
```

### Modding support

- Addding mods is supported through groot-rw directory. Before mounting, any files included in it will go above the mounted image and override any of the files. The path required for the mod may need to be created manually if its not directly in root next to the game binary.

- Some type of mods will not work with wine, such as ones that make use of dinput will likely cause crashes. Hooking use is also not supported by wine, regularly used in mods for games like GTA V.

- Note that groot-rw only applies for games that mount instead of extract.
