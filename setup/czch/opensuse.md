### Průvodce - OpenSUSE Tumbleweed

#### Hlavní balíčky
```sh
sudo zypper ar https://download.opensuse.org/repositories/home:/jc141/openSUSE_Tumbleweed/home:jc141.repo
sudo zypper refresh
sudo zypper install dwarfs fuse-overlayfs wine-staging wine-mono
```
<br>

#### Grafické balíčky
```sh
Vulkan řadiče
sudo zypper install libvulkan1 vulkan-tools
AMD řadiče
sudo zypper install libvulkan_radeon
INTEL řadiče
sudo zypper install libvulkan_intel
NVIDIA řadiče (příručka je prozatím nedokončená)
sudo zypper install libglvnd-32bit libglvnd
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
sudo zypper install libpulse-devel-32bit giflib-devel libgphoto2-6 libva2 gstreamer-plugins-base gstreamer-plugins-good gstreamer-plugins-ugly gstreamer-plugins-bad gstreamer-plugins-vaapi gstreamer-plugins-libav
```
