## Guia de Configuração - NixOS

### Pacotes principais
```sh
sudo nix-shell -p dwarfs wine-staging fuse-overlayfs
```

### Controladores (Drivers)

Segue a Wiki do NixOS para a tua unidade gráfica:

#### [Nvidia](https://nixos.wiki/wiki/Nvidia)

#### [Radeon/AMD](https://nixos.wiki/wiki/AMD_GPU)

#### [Intel](https://nixos.wiki/wiki/Intel_Graphics) - A página não fornece informações sobre como ativar o Vulkan; siga a página Radeon para essa parte.

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
sudo nix-shell gst-libav gst-plugins-bad1 gst-plugins-base1 gst-plugins-good1 gst-plugins-ugly1 gstreamer-vaapi
```
