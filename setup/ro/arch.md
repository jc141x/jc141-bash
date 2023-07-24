## Ghid de configurare - Arch Linux

*Note* - Arch Linux is rolling release and to keep it working properly a full update needs to be conducted regularly.

Acest ghid iti  va permite sa rulezi jocurile noastre pe un sistem Arch Linux. Alte distributii GNU/Linux pentru care poate fi folosit acesta sunt:

- EndeavourOS (instalator recomandat usor de folosit pentru Arch)
- Artix
- ArcoLinux
- Manjaro
- Alte distributii bazate pe Arch Linux
<br>

### Configurarea Pacman

Copy and paste the following commands into your terminal, you may need to use `Ctrl + Shift + V` to paste.

  1. Adauga repozitoriul rumpowered

     ```sh
     echo '
     [rumpowered]
     Server = https://jc141x.github.io/rumpowered-packages/$arch ' | sudo tee -a /etc/pacman.conf
     ```
  2. Adauga repozitoriul multilib

     ```sh
     sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
     ```
  3. Adauga si semneaza local cheile pentru repozitoriu

     ```sh
     sudo pacman-key --recv-keys cc7a2968b28a04b3
     ```

     ```sh
     sudo pacman-key --lsign-key cc7a2968b28a04b3
     ```
  4. Forteaza reimnprospateaza pachetelor si actualizeaza

     ```sh
     sudo pacman -Syyu
     ```
<br>

### Adauga pachetele de baza 

Aceste pachete sunt necesare pentru ca jocurile sa functioneze, daca nu le ai jocurile nu vor rula.

```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono
```
<br>

### Adauga pachetele grafice

Verifica daca placa ta video este AMD, INTEL sau NVIDIA dupa care urmareste instructiunile de mai jos. Lipeste-le apoi in terminal.

- Drivere pentru placi video de la AMD

    ```sh
    sudo pacman -S --needed lib32-vulkan-radeon vulkan-radeon lib32-vulkan-icd-loader
    ```
    - *Note*: For AMD GPUs please ensure that you do not have installed improper drivers with `sudo pacman -R amdvlk && sudo pacman -R vulkan-amdgpu-pro`. This software breaks the proper driver.

- Drivere pentru placi video de la Intel

    ```sh
    sudo pacman -S --needed lib32-vulkan-intel vulkan-intel lib32-vulkan-icd-loader
    ```
- Drivere pentru placi video NVIDIA

    ```sh
    sudo pacman -S --needed lib32-libglvnd lib32-nvidia-utils libglvnd nvidia lib32-vulkan-icd-loader
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
sudo pacman -S --needed lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-pipewire lib32-openal libgphoto2 libxcrypt-compat gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-plugins-base-libs lib32-gst-plugins-base lib32-gst-plugins-good
```
<br>

### Optional - Securitate

Activeaza scripturile sa blocheze activitatea WAN.

```
sudo pacman -S --needed rumpowered/bindtointerface rumpowered/lib32-bindtointerface
```
