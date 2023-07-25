## Průvodce - Fedora

#### Hlavní balíčky
```sh
sudo dnf copr enable jc141/DwarFS && sudo dnf install fuse-overlayfs dwarfs wine
```
<br>

#### Grafické balíčky

```sh
# Universální
sudo dnf install vulkan vulkan-loader

# nVidia specifické
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install xorg-x11-drv-nvidia akmod-nvidia
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

#### Doprovodné knihovny
```sh
sudo dnf install libxcrypt alsa-lib alsa-plugins-pulseaudio fluidsynth pulseaudio openal
```
