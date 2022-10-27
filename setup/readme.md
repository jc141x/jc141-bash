## jc141 setup guide

Haven't installed GNU/Linux yet? check out [EndeavourOS](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/)

### supported distro packages

#### [Arch](arch.md)
 - or: EndeavourOS (recommended), Arco, Artix, Manjaro etc.

#### [Debian Sid](debiansid.md)
 - or: Sparky Rolling, Siduction, Nitrux
#### [Fedora/Rawhide](fedora.md)
#### [OpenSUSE Tumbleweed](opensuse.md)

### not supported distros

Releases might work but we can't promise anything and don't want to waste time troubleshooting, for setup look at what most closely resembles your distro and use common sense. For example, if you use apt as your package manager you go for debian.

 - Ubuntu (malware)
   - And all distros based on it: Kubuntu, Lubuntu, Xubuntu, Mint, Elementary OS, Zorin OS, POP! OS, LXLE, KDE Neon 
 - SteamOS (malware, read-only, lack of packages)
 - Fedora Silverblue (read-only)

### hardware support

- The GPU/APU must have vulkan support otherwise hardly any releases with wine will run.

- The dwarfs mounting system requires modern speed standards from storing devices as well as RAM.

#### [SteamDeck support on Arch](steamdeck.md)

### running

```sh
cd "path to extracted game"
bash start.w.sh - or however the script is named.

To enable terminal output, add DBG=1 before bash command.
```
- settings.sh commands
```
bash settings.sh extract-dwarfs / unmount-dwarfs / mount-dwarfs / delete-dwarfs / compress-to-dwarfs
```

#### modding on dwarfs

- Addding mods is supported through groot-rw directory. Before mounting, any files included in it will go above the mounted image and override any of the files. The path required for the mod may need to be created manually.

- Games which are extracted do not require this method.

#### other notes

- The testing is done on Arch or EndeavourOS with EXT4, BTRFS or XFS filesystems.
