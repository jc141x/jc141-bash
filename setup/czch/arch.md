## Průvodce - Arch Linux

*Poznámka* - Arch Linux je "rolling release" distribuce (neexistují samostatné verze, programy jsou neustále aktualizovány). To znamená, že pro řádnou funkčnost systému je nutné jej periodicky aktualizovat.

Tento průvodce vám umožní hrát naše vydání na systému založeném na Arch Linuxu. Ostatní distribuce, které můžou používat tuto příručku jsou:

- EndeavourOS (doporučeno kvůli jednoduchému instalátoru a prekonfiguraci pro Arch)
- Artix
- ArcoLinux
- Manjaro
- Většina ostatních distribucí založena na Arch Linuxu
<br>

### Pacman konfigurace

Zkopírujte a vložte následující příkazy do terminálu. Ve většině terminálů budete muset použít `Ctrl + Shift + V` pro vložení místo standardního Ctrl + V.

  1. Přidejte repozitář Rumpowered.

     ```sh
     echo '
     [rumpowered]
     Server = https://jc141x.github.io/rumpowered-packages/$arch ' | sudo tee -a /etc/pacman.conf
     ```
  2. Přidejte balíčky multilib.

     ```sh
     sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
     ```
  3. Přidejte a lokálně podepište klíče pro repozitář.

     ```sh
     sudo pacman-key --recv-keys cc7a2968b28a04b3
     ```

     ```sh
     sudo pacman-key --lsign-key cc7a2968b28a04b3
     ```
  4. Plně aktualizujte systém.

     ```sh
     sudo pacman -Syyu
     ```
<br>

### Přidejte nutné balíčky

Všechny tyto balíčky jsou nutné pro naše vydání. Pokud je nenainstalujete, hry se nespustí.

```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono
```
<br>

### Přidejte grafické balíčky pro vaše zařízení

Zkontrolujte, jestli je vaše grafická karta od AMD, Intelu nebo nVidie, a pokračujte dle instrukcí pro vaši kartu níže. Vložte je do terminálu. Budete muset postupovat dle instrukcí pro řadiče Vulkan a instrukcí pro jednu z grafických karet.

- GPU/APU řadiče pro AMD karty.

    ```sh
    sudo pacman -S --needed lib32-vulkan-radeon vulkan-radeon lib32-vulkan-icd-loader
    ```
    - *Poznámka*: Pro AMD karty se prosím ujistěte, že nemáte nainstalované nesprávné řadiče pomocí `sudo pacman -R amdvlk && sudo pacman -R vulkan-amdgpu-pro`. Tento software činí správný řadič nefunkčním.

- GPU/APU řadiče pro Intel karty.

    ```sh
    sudo pacman -S --needed lib32-vulkan-intel vulkan-intel lib32-vulkan-icd-loader
    ```
- GPU řadiče pro nVidia karty.

    ```sh
    sudo pacman -S --needed lib32-libglvnd lib32-nvidia-utils libglvnd nvidia lib32-vulkan-icd-loader
    ```
<br>

#### Konfigurace hybridních systému (nejspíše notebooky/laptopy).

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

### Instalace doprovodných knihoven

Některé hry vyžadují další knihovny, aby se spustily. Vřele doporučujeme nainstalovat tyto knihovny:

```sh
sudo pacman -S --needed lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-pipewire lib32-openal libgphoto2 libxcrypt-compat gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-plugins-base-libs lib32-gst-plugins-base lib32-gst-plugins-good
```
<br>

#### Volitelné - bezpečnostní funkce

Umožní startovacím skriptům blokovat WAN aktivitu.

```
sudo pacman -S --needed rumpowered/bindtointerface rumpowered/lib32-bindtointerface
```
