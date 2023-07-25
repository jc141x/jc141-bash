## Průvodce - SteamDeck - Arch Linux

*Poznámka* - Arch Linux je "rolling release" distribuce (neexistují samostatné verze, programy jsou neustále aktualizovány). To znamená, že pro řádnou funkčnost systému je nutné jej periodicky aktualizovat.

- Problémy hlaste na náš matrix.

#### Nainstalujte libovolnou Arch distribuci. My doporučujeme Endeavour OS.

1. Vytvořte spustitelný USB flash disk se souborem ISO distribuce - [Příručka](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/)
2. Použijte USB-C adaptér pro připojení disku k vašemu SteamDecku (pokud disk nemá zabudovaný USB-C konektor)
3. Vypněte SteamDeck, držte 'Hlasitost dolů' a zmáčkněte Tlačítko napájení. Jakmile uslyšíte zvuk, pusťte tlačítko hlasitosti.
4. Vyberte USB EFI zařízení.
5. Pokračujte dle instrukcí instalátoru. Vyberte KDE Plasma pro nejméně problémů po instalaci (instalace online).
6. Spusťte nově nainstalovaný systém a v terminálu spusťte `sudo pacman -Syyu` (aktualizace systému), poté systém restartujte.
<br>

#### Přidejte nutné repozitáře

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

#### SteamDeck hardwarové řadiče

```sh
sudo pacman -S jupiter-staging/linux-neptune jupiter-staging/linux-neptune-headers jupiter-staging/linux-firmware-neptune jupiter-staging/jupiter-hw-support rumpowered/sc-controller
```
 
Udělejte nový kernel výchozí

```sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Restartujte a zvolte možnost s `linux neptune` pomocí šipek.
<br>

#### Hlavní balíčky
```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono lib32-vulkan-icd-loader lib32-vulkan-radeon vulkan-radeon
```
<br>

#### Různé knihovny vyžadovány některými hrami
```sh
sudo pacman -S --needed lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib libgphoto2 libxcrypt-compat gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-plugins-base-libs lib32-gst-plugins-base lib32-gst-plugins-good
```
<br>

#### Volitelné - bezpečnostní funkce

Umožní startovacím skriptům blokovat WAN aktivitu.

```
sudo pacman -S --needed rumpowered/bindtointerface rumpowered/lib32-bindtointerface bubblewrap
```
<br>

#### Po instalaci

Na KDE Plasma možná budete muset jít do nastavení a nastavit správné umístění obrazovky. Na jiných rozhraních možná nebudete mít tuto možnost.
