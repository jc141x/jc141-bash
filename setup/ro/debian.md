## Ghid de configurare - Debian Rolling/Sid

- Se aplica si la Sparky Rolling, Siduction, Nitrux care sunt deja rolling.

#### Muta-te pe repozitoriul Rolling/Sid.

#### Codul de mai jos se aplica doar pentru Debian Stable sau Testing. Nu folosi pe Kali sau alt distro modificat.
```sh
1. Edit /etc/apt/sources.list:
sudo nano /etc/apt/sources.list

2. Edit sources.list to only use these repos:

deb http://deb.debian.org/debian/ sid main contrib non-free
deb-src http://deb.debian.org/debian/ sid main

3. Save the file and update your system to Sid (This will reboot your system):

sudo apt update && sudo apt full-upgrade && sudo reboot
```
- Optionally you can install `apt-listbugs apt-listchanges` to read the bugs and see if any of them will break your distro.
<br>

#### Repozitoriile MPR, MPR helper si wine
```sh
sudo dpkg --add-architecture i386
export MAKEDEB_RELEASE='makedeb'
bash -c "$(wget -qO - 'https://shlink.makedeb.org/install')" && sudo apt update && sudo apt install git && git clone https://mpr.hunterwittenborn.com/una-bin.git && cd una-bin && makedeb -si
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources
```
<br>

### Adauga pachetele de baza 

Aceste pachete sunt necesare pentru ca jocurile sa functioneze, daca nu le ai jocurile nu vor rula.

```sh
git clone https://mpr.makedeb.org/dwarfs-bin.git && cd dwarfs-bin && makedeb -si
sudo apt install fuse-overlayfs winehq-staging
```
<br>

### Adauga pachetele grafice
```sh
Drivere Vulkan (AMD/INTEL/NVIDIA)
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

#### Configureaza device-uri Hibride (daca este cazul)

Un dispozitiv hibird este unul in care placa video integrata cat si dedicata sunt pregatite sa ruleze programele rulate de utilizator. GNU/Linux in general va folosi placa video integrata daca nu este specificat sa procedeze altcumva. Utilizarea placii video integrate nu este ideal pentru performanta.

Comanda de mai jos va face ca placa video dedicata sa fie utilizata in mod implicit.

Daca placata ta video dedicata este Radeon, ruleaza aceasta comanda: (se aplica doar in cazul in care placa video integrata este Intel)

```
echo 'VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json' | sudo tee -a /etc/environment
```

Daca placa ta video dedicata este NVIDIA, ruleaza aceasta comanda cand pornesti jocul:

```
__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia  __VK_LAYER_NV_optimus=NVIDIA_only VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.json bash start-script.sh
```

- In moment de fata nu putem aproviziona o metoda de a face sistemul sa foloseasca placa video dedicata in mod implicit din cauza driverului proprietar.
<br>

### Instaleaza librarii aditionale

Unele jocuri au nevoie de librarii aditionale pentru a rula. Noi recomandam instalarea urmatoarelor librarii pentru a evita probleme.

```sh
sudo apt install libva2 giflib-tools libgphoto2-6 libxcrypt-source libva2:i386 alsa-utils:i386 libopenal1:i386 libpulse0:i386 gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-vaapi gstreamer1.0-libav gstreamer1.0-plugins-good:i386 gstreamer1.0-plugins-base:i386
```
<br>

### Optional - Securitate

Activeaza scripturile sa blocheze activitatea WAN.

```
una install bindtointerface lib32-bindtointerface
```
