# Guía de Configuración - Arch Linux

*Nota* - Arch Linux es una distribución de liberación continua, y requiere de actualizaciones regulares para funcionar correctamente.

Esta guía te permitirá preparar nuestros lanzamientos en un sistema basado en Arch Linux. Otras distribuciones a las que aplica esta guía son:

- EndeavourOS (recomendado por su fácil instalación y por sus configuraciones por defecto para Arch)
- Artix
- ArcoLinux
- Manjaro
- Otras distribuciones basadas en Arch Linux
<br>

### Configuación de Pacman

Copia y pega los siguientes comandos en tu terminal. Puede que necesites presionar `Ctrl + Shift + V` para pegar.

  1. Agrega el repositorio rumpowered

     ```sh
     echo '
     [rumpowered]
     Server = https://jc141x.github.io/rumpowered-packages/$arch ' | sudo tee -a /etc/pacman.conf
     ```
  2. Agrega el repositorio multilib

     ```sh
     sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
     ```
  3. Agrega y firma localmente la clave para el repositorio rumpowered

     ```sh
     sudo pacman-key --recv-keys cc7a2968b28a04b3
     ```

     ```sh
     sudo pacman-key --lsign-key cc7a2968b28a04b3
     ```

  4. **Sólo para Manjaro**. Cambiar a la rama inestable

     ```sh
     sudo pacman-mirrors --api --set-branch unstable && sudo pacman-mirrors --fasttrack 5
     ```
     
  5. Fuerza la actualización de todos los paquetes (incluso si están al día) y actualiza el sistema.

     ```sh
     sudo pacman -Syyu
     ```
<br>

### Instalación de paquetes esenciales

Todos estos paquetes son requerimientos para que nuestras entregas funcionen. Si no los tienes, los juegos no van a ejecutarse.

```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono
```
<br>

### Instalación de paquetes de gráficos para tu equipo.

Revisa si tu tarjeta gráfica es AMD, INTEL, o NVIDIA. Luego, sigue las instrucciones correspondientes debajo copiándolas en tu terminal. Necesitaras seguir las instrucciones para los drivers de Vulkan y una de las instrucciones para tu GPU.

- Drivers de GPU/APU requeridos para GPUs de AMD

    ```sh
    sudo pacman -S --needed lib32-vulkan-radeon vulkan-radeon lib32-vulkan-icd-loader
    ```
    - *Nota*: Para GPU's de AMD, asegúrate de que no has instalados drivers incorrectos con `sudo pacman -R amdvlk && sudo pacman -R vulkan-amdgpu-pro`. Este software puede estropear al driver apropiado.

- Drivers de GPU/APU requeridos para GPUs de INTEL

    ```sh
    sudo pacman -S --needed lib32-vulkan-intel vulkan-intel lib32-vulkan-icd-loader
    ```
- Drivers de GPU requeridos para GPUs de NVIDIA

    ```sh
    sudo pacman -S --needed lib32-libglvnd lib32-nvidia-utils libglvnd nvidia lib32-vulkan-icd-loader
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

### Instalación de paquetes adicionales.

Algunos juegos requieren de paquetes adicionales para ejecutarse exitosamente. Recomendamos encarecidamente que instales los siguientes paquetes.

```sh
sudo pacman -S --needed lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-pipewire lib32-openal libgphoto2 libxcrypt-compat gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-plugins-base-libs lib32-gst-plugins-base lib32-gst-plugins-good
```
<br>

### Opcional - Características de seguridad

Permite a los scripts de inicio bloquear actividad en la red WAN.

```
sudo pacman -S --needed rumpowered/bindtointerface rumpowered/lib32-bindtointerface
```
