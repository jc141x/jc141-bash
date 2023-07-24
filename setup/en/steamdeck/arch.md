## Setup Guide - SteamDeck - Arch

*Note* - Arch Linux is rolling release and to keep it working properly a full update needs to be conducted regularly.

- Report issues you are having to us on matrix.

#### Install any Arch distro. We recommend EndeavourOS.

1. Create a bootable usb drive with the distro iso. - [Guide](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/)
2. Use a USB-C adapter to connect the drive to your deck.
3. Turn off your deck, hold 'Volume Down' and click the Power button, when you hear a sound let go of the volume button.
4. Select the usb efi device.
5. Follow installer steps. Pick KDE Plasma if you want to deal with least amount of issues. (online install)
6. Boot into new system and run `sudo pacman -Syyu` then reboot again.
<br>

#### Add required repos

```sh
echo '

[rumpowered]
SigLevel = Never
Server = https://jc141x.github.io/rumpowered-packages/$arch

[jupiter-staging]
Server = https://steamdeck-packages.steamos.cloud/archlinux-mirror/$repo/os/$arch
SigLevel = Never

[holo-staging]
Server = https://steamdeck-packages.steamos.cloud/archlinux-mirror/$repo/os/$arch
SigLevel = Never ' | sudo tee -a /etc/pacman.conf

sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf

sudo pacman -Syyu
```
<br>

#### SteamDeck Hardware drivers

```sh
sudo pacman -S jupiter-staging/linux-neptune jupiter-staging/linux-neptune-headers jupiter-staging/linux-firmware-neptune jupiter-staging/jupiter-hw-support rumpowered/sc-controller
```
 
Make new kernel default

```sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Reboot and select the option with `linux neptune` using the arrow keys.
<br>

#### Main packages
```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono lib32-vulkan-icd-loader lib32-vulkan-radeon vulkan-radeon
```
<br>

#### Various libraries required by some games
```sh
sudo pacman -S --needed lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib libgphoto2 libxcrypt-compat gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-plugins-base-libs lib32-gst-plugins-base lib32-gst-plugins-good
```
<br>

#### Optional - Security features

Enables start scripts to block WAN activity.

```
sudo pacman -S --needed rumpowered/bindtointerface rumpowered/lib32-bindtointerface bubblewrap
```
<br>

#### Post-setup

On KDE Plasma, you might need to go into settings and set the correct screen position. On other DE's you might be stuck with no such options.
