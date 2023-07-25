<h3>Guia de Configuração - Fedora</h3>

##### Pacotes principais
```sh
sudo dnf copr enable jc141/DwarFS && sudo dnf install fuse-overlayfs dwarfs wine
```
<br>

#### Pacotes gráficos

```sh
# Universal
sudo dnf install vulkan vulkan-loader

# Específicos para NVIDIA
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf install xorg-x11-drv-nvidia akmod-nvidia
```
<br>

#### Confuguração para setups híbridos (provavelmente laptops).

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

#### Bibliotecas adicionais
```sh
sudo dnf install libxcrypt alsa-lib alsa-plugins-pulseaudio fluidsynth pulseaudio openal
```
