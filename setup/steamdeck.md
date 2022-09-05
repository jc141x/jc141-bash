<h3>Setup Guide - SteamDeck</h3>

- Report issues you are having to us on matrix.

#### Install any Arch distro. We recommend EndeavourOS.

1. Create a bootable EndeavourOS usb drive. - [Guide](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/)
2. Use a USB-C adapter to connect the drive to your deck.
3. Turn off your deck, hold 'Volume Down' and click the Power button, when you hear a sound let go of the volume button.
4. Select the usb efi device.
5. Follow installer steps. (online install)
6. Boot into new system and run `sudo pacman -Syyu` then reboot again.

#### add required repos

```sh
echo '

[rumpowered]
SigLevel = Never
Server = https://repo.rumpowered.org/$arch

[jupiter]
Server = https://steamdeck-packages.steamos.cloud/archlinux-mirror/$repo/os/$arch
SigLevel = Never

[holo]
Server = https://steamdeck-packages.steamos.cloud/archlinux-mirror/$repo/os/$arch
SigLevel = Never ' | sudo tee -a /etc/pacman.conf

sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
```

```sh
sudo pacman -Syyu
```
- Update system again.

#### finalize

To get drivers for the hardware, install the following packages

```sh
sudo pacman -S jupiter/linux-neptune jupiter/linux-neptune-headers jupiter/linux-firmware-neptune jupiter/jupiter-hw-support
```

> -- insert gude how to change default boot option here --

Run `sudo grub-mkconfig -o /boot/grub/grub.cfg`

Reboot and select the option with `linux neptune` using the arrow keys.

------------------------------------------------------------------------------------------------------

### main packages

#### dwarfs and fuse-overlayfs
```sh
sudo pacman -S --needed rumpowered/dwarfs-bin fuse-overlayfs
```

#### graphics packages
```sh
# Universal
sudo pacman -S --needed lib32-vulkan-icd-loader vulkan-icd-loader lib32-vulkan-radeon vulkan-radeon gamescope
```

#### wine-staging-tkg + wine-mono + dxvk + vkd3d
```sh
sudo pacman -S --needed rumpowered/wine-staging-tkg rumpowered/dxvk-bin rumpowered/vkd3d-proton-bin rumpowered/windep wine-mono
```

#### various libraries required by some games
```sh
sudo pacman -S --needed lib32-giflib lib32-gnutls lib32-libxcomposite lib32-libxinerama lib32-libxslt lib32-mpg123 lib32-v4l-utils lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib giflib libgphoto2 libxcrypt-compat zlib aria2
```

#### gstreamer
```sh
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si

yay -S --needed gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav
# 32bit
yay -S --needed lib32-gst-plugins-base lib32-gst-plugins-good rumpowered/lib32-gst-plugins-ugly lib32-gst-plugins-bad
```
