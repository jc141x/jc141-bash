## Guía de Configuración - SteamDeck - Arch

*Nota* - Arch Linux es una distribución de liberación continua, y requiere de actualizaciones regulares para funcionar correctamente.

- Reporta los problemas que tengas en matrix.

#### Instala cualquier distro basada en Arch. Recomendamos EndeavourOS.

1. Crea un usb arrancable con el .iso de la distro. - [Guía](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/)
2. Usa un adaptador USB-C para conectar el usb a tu deck.
3. Apaga tu deck, mantén pulsado 'Bajar Volumen' y pulsa el botón de encender, cuando oigas un sonido suelta el botón de volumen.
4. Selecciona efi usb device.
5. Sigue los pasos del instalador. Elige "KDE Plasma" para evitar problemas. (Instalación online)
6. Arranca tu nuevo sistema y ejecuta el comando `sudo pacman -Syyu`, luego reinicia de nuevo.
<br>

#### Añade los repos requeridas

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

#### Drivers de Hardware de SteamDeck

```sh
sudo pacman -S jupiter-staging/linux-neptune jupiter-staging/linux-neptune-headers jupiter-staging/linux-firmware-neptune jupiter-staging/jupiter-hw-support rumpowered/sc-controller
```
 
Hacer que el nuevo kernel sea predeterminado

```sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Reinicia y elige la opción con `linux neptune` con las flechas del teclado.
<br>

#### Paquetes esenciales
```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono lib32-vulkan-icd-loader lib32-vulkan-radeon vulkan-radeon
```
<br>

#### Varias librerías requeridas por algunos juegos
```sh
sudo pacman -S --needed lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib libgphoto2 libxcrypt-compat gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-plugins-base-libs lib32-gst-plugins-base lib32-gst-plugins-good
```
<br>

#### Opcional - Características de seguridad

Permite a los scripts de inicio bloquear actividad en la red WAN.

```
sudo pacman -S --needed rumpowered/bindtointerface rumpowered/lib32-bindtointerface bubblewrap
```
<br>

#### Post-installación

En KDE Plasma, puede que tengas que ir a Configuración y ajustar la posición de pantalla. En otros entornos de escritorio puede que no tengas esta opción.
