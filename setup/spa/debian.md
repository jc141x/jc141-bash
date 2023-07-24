## Guía de Configuración - Arch Linux

- Aplica también para Sparky Rolling, Siduction y Nitrux, que por defecto son de liberación continua.

#### Cambia al repositorio Rolling/Sid para una experiencia óptima y al día.
Nota. El repositorio Stable de Debian ha dejado de ser compatible con las últimas versiones de DXVK, por lo que no lo soportamos.
#### SÓLO PARA DEBIAN STABLE O TESTING. NO USAR EN KALI O EN OTRAS DISTRIBUCIONES MODIFICADAS BASADAS EN DEBIAN
```sh
1. Edita /etc/apt/sources.list:
sudo nano /etc/apt/sources.list

2. Edita sources.list para usar únicamente estos repositorios:

deb http://deb.debian.org/debian/ sid main contrib non-free
deb-src http://deb.debian.org/debian/ sid main

3. Guarda el archivo y actualiza tu sistema a Sid (Esto reiniciará tu sistema):

sudo apt update && sudo apt full-upgrade && sudo reboot
```
- Opcionalmente, puedes instalar `apt-listbugs apt-listchanges` para revisar bugs y ver si alguno de ellos podría estropear tu sistema.
<br>

#### MPR, asistente de MPR y repositorios de wine
```sh
sudo dpkg --add-architecture i386
export MAKEDEB_RELEASE='makedeb'
bash -c "$(wget -qO - 'https://shlink.makedeb.org/install')" && sudo apt update && sudo apt install git && git clone https://mpr.hunterwittenborn.com/una-bin.git && cd una-bin && makedeb -si
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources
```
<br>

#### Paquetes esenciales
```sh
git clone https://mpr.makedeb.org/dwarfs-bin.git && cd dwarfs-bin && makedeb -si
sudo apt install fuse-overlayfs winehq-staging
```
<br>

#### Paquetes de gráficos
```sh
Vulkan drivers (AMD/INTEL/NVIDIA)
sudo apt install libvulkan1 vulkan-tools
```
```sh
NVIDIA drivers
sudo wget -O- https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/3bf863cc.pub | gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg

echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list

sudo apt update && sudo apt upgrade -y

sudo apt install nvidia-driver nvidia-settings nvidia-smi nvidia-xconfig nvidia-opencl-icd nvidia-opencl-common nvidia-detect linux-image-amd64 linux-headers-amd64
```
<br>

#### Configuración de gráficos híbridos (comúnmente para laptops).

Una configuración de gráficos híbridos es aquella en la que el sistema dispone de una GPU integrada y una dedicada. Por lo general GNU/Linux usará la GPU integrada (lo cual no es adecuado para el rendimiento) a menos que se especifique lo contrario.

Los siguientes comandos asignarán por defecto a la GPU dedicada cuando se ejecuten comandos como los scripts de inicio de nuestras entregas.

Si tu GPU dedicada es Radeon, entonces ejecuta el siguiente comando:

```
echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' | sudo tee -a /etc/environment
```

Si tu CPU dedicada es Nvidia, entonces ejecuta el siguiente comando cuando inicies un juego:

```
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia  __VK_LAYER_NV_optimus=NVIDIA_only VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json bash start-script.sh
```

- No contamos con una manera de configurar esto por defecto porque estropea otros programas que van mejor con gráficos integrados (debido a los controladores propietarios).
<br>

#### Varias librerías requeridas por algunos juegos
```sh
sudo apt install libva2 giflib-tools libgphoto2-6 libxcrypt-source libva2:i386 alsa-utils:i386 libopenal1:i386 libpulse0:i386 gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-vaapi gstreamer1.0-libav gstreamer1.0-plugins-good:i386 gstreamer1.0-plugins-base:i386
```
<br>

### Opcional - Características de seguridad

Permite a los scripts de inicio bloquear actividad en la red WAN.

```
una install bindtointerface lib32-bindtointerface
```
