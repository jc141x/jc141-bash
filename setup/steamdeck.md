> When the guide says `edit` it means you edit the file with sudo using an editor like `nano` or `vim`.
> 
> e.g. `sudo nano /etc/pacman.conf` OR `sudoedit /etc/pacman.conf`

> Report issues you are having to us on matrix 

> If you need to revert back to steamOS, follow the [guide by valve](https://help.steampowered.com/en/faqs/view/1B71-EDF2-EB6D-2BB3)

# Install EndeavourOS

1. create a bootable EndeavourOS usb drive ([link](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/))
1. use a usb-c adapter to connect the drive to your deck
1. turn off your deck, hold 'Volume Down' and click the Power button, when you hear a sound let go of the volume button.
1. select the usb efi device
1. follow the instructions on the screen (online install)
# Prepare download sources

do a full system update before you start. `sudo pacman -Syyu`, and reboot.

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

# Finalize

to get drivers for the hardware (based on guesses), install the following packages with `sudo pacman -S`

    jupiter/linux-neptune
    jupiter/linux-neptune-headers
    jupiter/linux-firmware-neptune
    jupiter/jupiter-hw-support

> -- insert gude how to change default boot option here --

run `sudo grub-mkconfig -o /boot/grub/grub.cfg`

reboot and select the option with `linux neptune` using the arrow keys.

follow our [requirements guide](https://johncena141.eu.org:8141/reqs) for Arch, and reboot once more.

---

| Hardware | Working? | Note |
|---|---|---|
| GPU | Yes ||
| Wireless | Yes ||
| Audio | Yes | After drivers |
| Touchpad | Yes ||
| Touchscreen | Yes ||
| Controller | No | user error? needs investigation |
| Gyroscope | Untested ||
| Card reader (microSD) | No | Worked with LiveCD, driver? user error?|
| Bluetooth | Yes ||
| Battery | Yes ||
