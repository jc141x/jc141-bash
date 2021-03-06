<h3>Setup Guide - SteamDeck</h3>

<br>

> When the guide says `edit` it means you edit the file with sudo using an editor like `nano` or `vim`.
> 
> e.g. `sudo nano /etc/pacman.conf` OR `sudoedit /etc/pacman.conf`

> Report issues you are having to us on matrix 

> If you need to revert back to steamOS, follow the [guide by valve](https://help.steampowered.com/en/faqs/view/1B71-EDF2-EB6D-2BB3)

#### install EndeavourOS

1. Create a bootable EndeavourOS usb drive ([link](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/))
2. Use a usb-c adapter to connect the drive to your deck
3. Turn off your deck, hold 'Volume Down' and click the Power button, when you hear a sound let go of the volume button.
4. Select the usb efi device
5. Follow the instructions on the screen (online install)


#### prepare download sources

Do a full system update before you start. `sudo pacman -Syyu`, and reboot.

Add the lines to the __end__ of the pacman configuration file.

`sudoedit /etc/pacman.conf`

```toml
[jupiter]
Server = https://steamdeck-packages.steamos.cloud/archlinux-mirror/$repo/os/$arch
SigLevel = Never

[holo]
Server = https://steamdeck-packages.steamos.cloud/archlinux-mirror/$repo/os/$arch
SigLevel = Never
```

`sudo pacman -Syyu` to update the package database and install any replacement packages.

#### finalize

to get drivers for the hardware (based on guesses), install the following packages with `sudo pacman -S`

    jupiter/linux-neptune
    jupiter/linux-neptune-headers
    jupiter/linux-firmware-neptune
    jupiter/jupiter-hw-support

> -- insert gude how to change default boot option here --

run `sudo grub-mkconfig -o /boot/grub/grub.cfg`

reboot and select the option with `linux neptune` using the arrow keys.

follow our [requirements guide](arch.md) for Arch, and reboot once more.

<br>

| Hardware | Working? | Note |
|---|---|---|
| GPU | Yes ||
| Wireless | Yes ||
| Audio | No | External devices with sound cards work |
| Touchpad | Yes ||
| Touchscreen | Yes ||
| Controller | Partial | Some buttons work |
| Gyroscope | Untested ||
| Card reader (microSD) | Yes ||
| Bluetooth | Yes ||
| Battery | Yes ||
