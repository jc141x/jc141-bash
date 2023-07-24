## Průvodce - Mint

#### Aktualizujte systém
```
sudo apt update
sudo apt full-upgrade -y
```
- Pokud bylo něco aktualizováno, restartujte počítač.
<br>

#### MPR, MPR pomocník a Wine repozitáře
```sh
sudo dpkg --add-architecture i386
export MAKEDEB_RELEASE='makedeb'
bash -c "$(wget -qO - 'https://shlink.makedeb.org/install')" && sudo apt update && sudo apt install git && git clone https://mpr.hunterwittenborn.com/una-bin.git && cd una-bin && makedeb -si
```
Přidejte správný [winehq](https://wiki.winehq.org/Ubuntu) (klikněte na text) repozitář pro váš systém.
<br>

#### Hlavní balíčky
```sh
git clone https://mpr.makedeb.org/dwarfs-bin.git && cd dwarfs-bin && makedeb -si
sudo apt install fuse-overlayfs winehq-staging
```
<br>

#### Grafické balíčky
```sh
Vulkan řadiče (AMD/INTEL/NVIDIA)
sudo apt install libvulkan1 vulkan-tools
```
```sh
nVidia řadiče
sudo wget -O- https://developer.download.nvidia.com/compute/cuda/repos/debian11/x86_64/3bf863cc.pub | gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg

echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list

sudo apt update && sudo apt upgrade -y

sudo apt install nvidia-driver nvidia-settings nvidia-smi nvidia-xconfig nvidia-opencl-icd nvidia-opencl-common nvidia-detect linux-image-amd64 linux-headers-amd64
```
<br>

#### Konfigurace hybridních systémů (nejspíše notebooky/laptopy).

Hybridní systém je ten, kde integrované GPU a samostatné GPU jsou obě připravené být využity systémem. GNU/Linux obecně bude využívat integrované GPU, pokud nebude přikázáno jinak (což není optimální vzhledem k výkonnosti).

Příkaz níže poručí sytému, aby používal samostatné GPU při spuštění příkazu jako naše startovací skripty.

Pokud je vaše samostatné GPU Radeon (AMD), spusťte tento příkaz:

```
echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' | sudo tee -a /etc/environment
```

Pokud je vaše samostatné GPU nVidia, spusťte tento příkaz **při spuštění hry:**

```
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia  __VK_LAYER_NV_optimus=NVIDIA_only VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json bash start-script.sh
```

- Nemůžeme toto zvolit jako výchozí, protože to ničí ostatní software, který běží lépe s integrovaným GPU (kvůli uzavřenému nVidia řadiči).
<br>

#### Instalace doprovodných knihoven
```sh
sudo apt install libva2 giflib-tools libgphoto2-6 libxcrypt-source libva2:i386 alsa-utils:i386 libopenal1:i386 libpulse0:i386 gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-vaapi gstreamer1.0-libav gstreamer1.0-plugins-good:i386 gstreamer1.0-plugins-base:i386
```

<br>

#### Volitelné - bezpečnostní funkce

Umožní startovacím skriptům blokovat WAN aktivitu.

```
una install bindtointerface lib32-bindtointerface
```
