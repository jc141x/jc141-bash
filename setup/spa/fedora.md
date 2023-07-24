<h3>Guía de configuración - Fedora</h3>

#### Paquetes esenciales
```sh
sudo dnf copr enable jc141/DwarFS && sudo dnf install fuse-overlayfs dwarfs wine
```
<br>

#### Paquetes de gráficos

```sh
# Universal
sudo dnf install vulkan vulkan-loader

# específicos para NVIDIA
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install xorg-x11-drv-nvidia akmod-nvidia
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

#### Otras librerías
```sh
sudo dnf install libxcrypt alsa-lib alsa-plugins-pulseaudio fluidsynth pulseaudio openal
```
