### Guia de Configuração - Arch Linux

Nota - O Arch Linux é uma distribuição em constante atualização e, para mantê-lo a funcionar corretamente, é necessário fazer uma atualização completa regularmente.

Este guia irá permitir que tu configures os nossos jogos no Arch Linux. Outras distribuições GNU/Linux que podem usar este guia são:

    EndeavourOS (recomendado por nós por ter uma instalação fácil e já vir pre-configurado para o Arch)
    Artix
    ArcoLinux
    Manjaro
    Outras distribuições baseadas no Arch Linux

###Configuração do Pacman

Copia e cola os seguintes comandos no teu terminal, talvez seja necessário usar Ctrl + Shift + V para colar.

  1. Adicionar o repositório rumpowered

     ```sh
     echo '
     [rumpowered]
     Server = https://jc141x.github.io/rumpowered-packages/$arch ' | sudo tee -a /etc/pacman.conf
     ```
  2. Adicionar o repositório multilib 

     ```sh
     sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
     ```
  3. Adicionar e assinar localmente as chaves do repositório

     ```sh
     sudo pacman-key --recv-keys cc7a2968b28a04b3
     ```

     ```sh
     sudo pacman-key --lsign-key cc7a2968b28a04b3
     ```
  4. Forçar a atualização de todos os pacotes (mesmo que estejam atualizados) e atualizar

     ```sh
     sudo pacman -Syyu
     ```
<br>

### Adicionar pacotes principais necessários

Esses pacotes são todos necessários para que nossas configurações funcionem. Se não os tiveres, os jogos não serão executados.

```sh
sudo pacman -S --needed rumpowered/dwarfs fuse-overlayfs wine-staging wine-mono
```
<br>

### Adicionar pacotes gráficos para a sua configuração.

Verifica se a tua placa de vídeo é AMD, INTEL ou NVIDIA e segue as instruções associadas abaixo. Cola-as na terminal. Irás precisar de seguir as instruções para os Drivers Vulkan e uma das instruções da GPU.

- Drivers GPU/APU necessários para GPUs AMD

    ```sh
    sudo pacman -S --needed lib32-vulkan-radeon vulkan-radeon lib32-vulkan-icd-loader
    ```
    - *Nota*: Para GPUs AMD, certifica-te se não tens instalado drivers incorretos com `sudo pacman -R amdvlk && sudo pacman -R vulkan-amdgpu-pro`. Este software danifica o driver adequado.

- Drivers GPU/APU necessários para GPUs INTEL 

    ```sh
    sudo pacman -S --needed lib32-vulkan-intel vulkan-intel lib32-vulkan-icd-loader
    ```
- Drivers GPU/APU necessários para GPUs NVIDIA 

    ```sh
    sudo pacman -S --needed lib32-libglvnd lib32-nvidia-utils libglvnd nvidia lib32-vulkan-icd-loader
    ```
<br>

#### Configuranção de setups híbridos (mais provavelmente laptops).

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

### Instalar bibliotecas adicionais

Alguns jogos requerem bibliotecas adicionais para serem executados com sucesso. Recomendamos fortemente a instalação das seguintes bibliotecas.

```sh
sudo pacman -S --needed lib32-alsa-lib lib32-alsa-plugins lib32-libpulse lib32-pipewire lib32-openal libgphoto2 libxcrypt-compat gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gstreamer-vaapi gst-libav lib32-gst-plugins-base-libs lib32-gst-plugins-base lib32-gst-plugins-good
```
<br>

### Opcional - Recursos de segurança

Permite que os scripts de inicialização bloqueiem a atividade da WAN.

```
sudo pacman -S --needed rumpowered/bindtointerface rumpowered/lib32-bindtointerface
```
