## Guía de Configuración - NixOS

### Paquetes esenciales
```sh
sudo nix-shell -p dwarfs wine-staging fuse-overlayfs
```

### Drivers

Sigue la  Wiki de NixOS para tu unidad de gráficos:

#### [Nvidia](https://nixos.wiki/wiki/Nvidia)

#### [Radeon/AMD](https://nixos.wiki/wiki/AMD_GPU)

#### [Intel](https://nixos.wiki/wiki/Intel_Graphics) - La página no proporciona información de cómo activar Vulkan, ve a la página de Radeon para hacer eso.

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

### Install additional libraries
### Instalación de librerías adicionales

Algunos juegos requieren de paquetes adicionales para ejecutarse exitosamente. Recomendamos encarecidamente que instales los siguientes paquetes.

```sh
sudo nix-shell gst-libav gst-plugins-bad1 gst-plugins-base1 gst-plugins-good1 gst-plugins-ugly1 gstreamer-vaapi
```
