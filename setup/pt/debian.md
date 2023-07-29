#Guia de Configuração - Debian Rolling/Sid

- Aplica-se também ao Sparky Rolling, Siduction e Nitrux, que são rolling por padrão.

####Muda para o repositório Rolling/Sid para uma experiência ótima e atualizada.

Nota: O repositório do Debian Stable não é mais compatível com o DXVK mais recente, portanto, não é suportado.
#### SOMENTE PARA DEBIAN STABLE OU TESTING, NÃO UTILIZES NO KALI OU EM OUTRAS DISTRIBUIÇÕES BASEADAS NO DEBIAN MODIFICADAS


```sh
1. Edita /etc/apt/sources.list:
sudo nano /etc/apt/sources.list

2. Edita sources.list to only use these repos:

deb http://deb.debian.org/debian/ sid main contrib non-free
deb-src http://deb.debian.org/debian/ sid main

3. Guarda o arquivo e atualiza o sistema para o Sid (isso reiniciará o teu sistema):

sudo apt update && sudo apt full-upgrade && sudo reboot
```
- Opcionalmente, podes instalar `apt-listbugs apt-listchanges` para ler os bugs e verificar se algum deles irá estragar a tua distribuição.
<br>

#### Repositórios do MPR, MPR helper e wine
```sh
sudo dpkg --add-architecture i386
export MAKEDEB_RELEASE='makedeb'
bash -c "$(wget -qO - 'https://shlink.makedeb.org/install')" && sudo apt update && sudo apt install git && git clone https://mpr.hunterwittenborn.com/una-bin.git && cd una-bin && makedeb -si
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources
```
<br>

#### Pacotes principais
```sh
git clone https://mpr.makedeb.org/dwarfs-bin.git && cd dwarfs-bin && makedeb -si
sudo apt install fuse-overlayfs winehq-staging
```
<br>

#### Pacotes de gráficos
```sh
Vulkan drivers (AMD/INTEL/NVIDIA)
sudo apt install libvulkan1 libvulkan1:i386 vulkan-tools
```
```sh
NVIDIA drivers
sudo wget -O- https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/3bf863cc.pub | gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg

echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list

sudo apt update && sudo apt upgrade -y

sudo apt install nvidia-driver nvidia-settings nvidia-smi nvidia-xconfig nvidia-opencl-icd nvidia-opencl-common nvidia-detect linux-image-amd64 linux-headers-amd64
```
<br>

#### Configuração configurações híbridas (provavelmente laptops).

Uma configuração híbrida é aquela em que tanto uma GPU integrada quanto uma dedicada estão prontas para serem usadas pelo sistema. O GNU/Linux geralmente usará a GPU integrada por padrão, a menos que seja informado de outra forma (o que não é bom para o desempenho).

Os comandos abaixo tornarão a GPU dedicada a opção padrão ao executar comandos, como os scripts de inicialização.

Se a tua GPU dedicada for Radeon, executa o seguinte comando:

```
echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' | sudo tee -a /etc/environment
```

Se a tua GPU dedicada for Nvidia, executa o seguinte comando ao iniciar o jogo:


```
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia  __VK_LAYER_NV_optimus=NVIDIA_only VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json bash start-script.sh
```

- Não podemos fornecer um método para tornar isso padrão no sistema devido a problemas com outros softwares que funcionam melhor com gráficos integrados (devido ao driver proprietário).
<br>

#### Várias bibliotecas necessárias para alguns jogos
```sh
sudo apt install libva2 giflib-tools libgphoto2-6 libxcrypt-source libva2:i386 alsa-utils:i386 libopenal1:i386 libpulse0:i386 gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-vaapi gstreamer1.0-libav gstreamer1.0-plugins-good:i386 gstreamer1.0-plugins-base:i386
```
<br>

#### Opcional - Recursos de segurança

Permite que os scripts de inicialização bloqueiem a atividade da WAN.

```
una install bindtointerface lib32-bindtointerface
```
