## Setup Guide - SteamDeck - Arch

*Note* - Arch Linux is rolling release and to keep it working properly a full update needs to be conducted regularly.

- Raporteaza probleme pe care le ai pe comunitatea noastra de Matrix.

#### Instaleaza o distributie Arch. Noi recomandam EndeavourOS.

1. Creeaza un USB bootabil cu un iso de distro GNU/Linux. - [Ghid](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/) (engleza)
2. Utilizeaza un adaptor USB-C pentru a conecta un stick in deck-ul tau.
3. Inchide Deck-ul, apasa 'Volum Jos' si apasa butonul de Deschidere/Power. Cand auzi un sunet, ridica degetul de pe butonul de volum.
4. Selecteaza device-ul USB EFI.
5. Urmareste pasii instalatorului. Alege KDE Plasma daca vrei sa ai cat mai putin probleme. (instalare online ideal)
6. Deschide noul sistem si ruleaza 'sudo pacman -Syyu' apoi reporneste din nou.
<br>

#### Adauga repozitoriile necesare

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

#### Drivere Hardware pentru SteamDeck

```sh
sudo pacman -S jupiter-staging/linux-neptune jupiter-staging/linux-neptune-headers jupiter-staging/linux-firmware-neptune jupiter-staging/jupiter-hw-support rumpowered/sc-controller
```

Alege noul kernel ca implicit

```sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Restarteaza si selecteaza optiunea 'linux neptune' utilizand sagetile.
<br>

### Adauga pachetele de baza 

Aceste pachete sunt necesare pentru ca jocurile sa functioneze, daca nu le ai jocurile nu vor rula.

```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono lib32-vulkan-icd-loader lib32-vulkan-radeon vulkan-radeon
```
<br>

### Instaleaza librarii aditionale

Unele jocuri au nevoie de librarii aditionale pentru a rula. Noi recomandam instalarea urmatoarelor librarii pentru a evita probleme.

```sh
sudo pacman -S --needed lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib libgphoto2 libxcrypt-compat gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-plugins-base-libs lib32-gst-plugins-base lib32-gst-plugins-good
```
<br>

### Optional - Securitate

Activeaza scripturile sa blocheze activitatea WAN.

```
sudo pacman -S --needed rumpowered/bindtointerface rumpowered/lib32-bindtointerface bubblewrap
```
<br>

#### Dupa completare

In KDE Plasma, este posibil sa trebuiasca sa intri la setari si sa setezi pozitia corecta a ecranului.
