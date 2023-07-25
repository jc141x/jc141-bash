### Setup Guide - OpenSUSE Tumbleweed

#### Core packages
```sh
sudo zypper ar https://download.opensuse.org/repositories/home:/jc141/openSUSE_Tumbleweed/home:jc141.repo
sudo zypper refresh
sudo zypper install dwarfs fuse-overlayfs wine-staging wine-mono
```
<br>

#### Graphics packages
```sh
Vulkan drivers
sudo zypper install libvulkan1 vulkan-tools
AMD drivers
sudo zypper install libvulkan_radeon
INTEL drivers
sudo zypper install libvulkan_intel
NVIDIA drivers (guide incomplete for now)
sudo zypper install libglvnd-32bit libglvnd
```
<br>

#### Configuranção de setups híbridos (mais provavelmente laptops).

Um setup híbrido é aquele em que tanto uma GPU integrada quanto uma dedicada estão prontas para serem usadas pelo sistema. O GNU/Linux geralmente utiliza a GPU integrada como padrão, a menos que seja especificado o contrário (o que não é bom para o desempenho).

O comando abaixo definirá a GPU dedicada como padrão ao executar comandos, como os scripts de inicialização.

Se a tua GPU dedicada for Radeon, executa o seguinte comando:

```
echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' | sudo tee -a /etc/environment
```

Se a tua GPU dedicada for Nvidia, executa o seguinte comando ao iniciar o jogo:

```
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia  __VK_LAYER_NV_optimus=NVIDIA_only VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json bash start-script.sh
```

- Não podemos fornecer uma forma de tornar isso padrão no sistema devido a isso causar problemas em outros softwares que funcionam melhor com gráficos integrados (devido ao driver proprietário).
<br>

#### Diversas bibliotecas necessárias para alguns jogos
```sh
sudo zypper install libpulse-devel-32bit giflib-devel libgphoto2-6 libva2 gstreamer-plugins-base gstreamer-plugins-good gstreamer-plugins-ugly gstreamer-plugins-bad gstreamer-plugins-vaapi gstreamer-plugins-libav
```
