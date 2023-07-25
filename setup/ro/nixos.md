## Ghid de configurare - NixOS

### Adauga pachetele de baza 

Aceste pachete sunt necesare pentru ca jocurile sa functioneze, daca nu le ai jocurile nu vor rula.

```sh
sudo nix-shell -p dwarfs wine-staging fuse-overlayfs
```

### Drivere

Urmareste NixOS Wiki pentru placa ta video:

#### [Nvidia](https://nixos.wiki/wiki/Nvidia)

#### [Radeon/AMD](https://nixos.wiki/wiki/AMD_GPU)

#### [Intel](https://nixos.wiki/wiki/Intel_Graphics) - Pagina nu aprovizioneaza informatii despre adaugarea suportului pentru Vulkan, urmareste pagina Radeon pentru aceasta parte.

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
sudo nix-shell gst-libav gst-plugins-bad1 gst-plugins-base1 gst-plugins-good1 gst-plugins-ugly1 gstreamer-vaapi
```
