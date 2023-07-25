## Setup Guide - SteamDeck - Arch

Guia de Configuração - SteamDeck - Arch

*Nota* - O Arch Linux é uma distribuição em constante atualização e, para mantê-lo funcionando corretamente, é necessário fazer uma atualização completa regularmente.

    Reporta os problemas que está tiveres para nós no Matrix.

#### Instala qualquer distribuição Arch. Recomendamos o EndeavourOS.

    Cria uma unidade USB inicializável com a imagem ISO da distribuição. - [Guia](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/)
1. Usa um adaptador USB-C para conectar a unidade ao teu deck.
2. Desligua o deck, mantendo pressionado 'Volume Down' e cliqua no botão Power. Quando ouvires um som, solta o botão de volume.
3. Seleciona o dispositivo de inicialização USB EFI.
4. Segue as etapas do instalador. Escolhe o KDE Plasma se desejares lidar com a menor quantidade de problemas. (instalação online)
5. Inicia o novo sistema e executa `sudo pacman -Syyu`, em seguida, reinicia novamente.
<br>

#### Adicionar repositórios necessários

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

#### Drivers de Hardware do SteamDeck

```sh
sudo pacman -S jupiter-staging/linux-neptune jupiter-staging/linux-neptune-headers jupiter-staging/linux-firmware-neptune jupiter-staging/jupiter-hw-support rumpowered/sc-controller
```
 
Definir o novo kernel como padrão.

```sh
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

Reinicia e seleciona a opção com `linux neptune` usando as teclas de seta.
<br>

#### Pacotes principais
```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono lib32-vulkan-icd-loader lib32-vulkan-radeon vulkan-radeon
```
<br>

#### Várias bibliotecas necessárias por alguns jogos
```sh
sudo pacman -S --needed lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-openal lib32-zlib libgphoto2 libxcrypt-compat gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-plugins-base-libs lib32-gst-plugins-base lib32-gst-plugins-good
```
<br>

#### Opcional - Recursos de segurança

Permite que os scripts de inicialização bloqueiem a atividade da WAN.

```
sudo pacman -S --needed rumpowered/bindtointerface rumpowered/lib32-bindtointerface bubblewrap
```
<br>

#### Pós-configuração

No KDE Plasma, tu podes precisar de aceder as configurações e ajustar corretamente a posição da tela. Em outros ambientes de desktop, tu podes ficar preso sem opções semelhantes.
