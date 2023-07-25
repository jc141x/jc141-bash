<h3>Ghid de configurare - Fedora</h3>

#### Pachete de baza
```sh
sudo dnf copr enable jc141/DwarFS && sudo dnf install fuse-overlayfs dwarfs wine
```
<br>

#### Pachete grafice

```sh
# Universal
sudo dnf install vulkan vulkan-loader

# NVIDIA specific
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install xorg-x11-drv-nvidia akmod-nvidia
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
sudo dnf install libxcrypt alsa-lib alsa-plugins-pulseaudio fluidsynth pulseaudio openal
```
