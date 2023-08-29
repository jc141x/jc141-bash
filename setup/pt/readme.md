## Guia de Configuração jc141

Ainda não instalaste o GNU/Linux ou procuras uma recomendação? Vê o [EndeavourOS](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/).

Sugestões para quaisquer alterações neste repositório são bem-vindas no [Matrix](https://matrix.to/#/%21aRyMmzPUzcUKRXpVtP%3Amatrix.org?via=catgirl.cloud&via=grin.hu&via=matrix.org).

Máquinas virtuais não são suportadas.
<br>

### Distribuições GNU/Linux Suportadas

Clique nos seguintes links para configurar a sua distribuição GNU/Linux.

*   [Arch](arch.md) incluindo: Endeavour OS, Arco, Artix, Manjaro and others.
*   [Debian Sid/Rolling](debian.md) incluindo: Nitrux, Sparky Rolling and Siduction.
*   [Fedora](fedora.md) incluindo: Rawhide. - Pacote DWARFS desatualizado. Novos lançamentos temporariamente inutilizáveis.
*   [NixOS](nixos.md) - Pacote DWARFS desatualizado. Novos lançamentos temporariamente inutilizáveis.
*   [Mint](mint.md) incluindo: Pop!_OS
<br>

### Suporte de Hardware

O teu hardware gráfico (GPU/APU) **deve** ter suporte para Vulkan 1.3 nas versões que utilizam DXVK e VKD3D, marcadas como start.e-w.sh para o script de início.

Versões com start.n-w.sh requerem suporte a Vulkan, mas não necessariamente a versão 1.3. Versões com start.n.sh geralmente não requerem suporte a Vulkan.

#### [Suporte para SteamDeck no Arch](steamdeck/arch.md)
<br>

### Como Executar o Jogo

Abre um terminal e executa o seguinte comando. Edita-o conforme necessário.

ATENÇÃO! - Usar sh em vez de bash não funciona! Utiliza apenas bash ou ./ com permissão de execução.

```
bash /Path/to/Game/start.{n/e-w/n-w}.sh
```

Variáveis de ambiente disponíveis:
```
CACHEPERCENT=15 - Percentagem da RAM total do hardware a ser usada pelos dwarfs como cache. Quanto maior, melhor será a fluidez (não necessariamente impactante se for aumentado ainda mais). O valor padrão é 15%.

DBG=1 - Ativa o output no terminal do binário e/ou do wine.

WANBLK=0 - Desativa o bloqueio de WAN, que está ativado por padrão se o pacote 'bindtointerface' estiver instalado.

UNMOUNT=0 - Desativa a desmontagem automática da imagem dos dwarfs de 'files/groot'.
```
<br>

### Dwarfs
O ficheiro settings.sh fornece alguns comandos opcionais que podem ser úteis.

```
bash settings.sh COMMAND

Comandos Disponíveis (versão mais antiga)
  extract (extract-dwarfs)
  unmount (unmount-dwarfs)
  mount (mount-dwarfs)
  delete-image (delete-dwarfs)
  compress (compress-dwarfs)
```
O comando de extração fará com que o script use automaticamente os ficheiros extraídos e não tente executar a montagem novamente até que o diretório groot esteja novamente ausente/vazi (se o script estiver configurado para fazer a montagem por padrão).
<br><br>

### Modding
A adição de um mod é suportada através do uso do diretório files/groot-rw. Adiciona ficheiros diretamente a ele ou monte os ficheiros do jogo conforme mencionado acima e adiciona ou edita ficheiros no diretório 'files/groot'.

Esses ficheiros serão salvos no diretório 'files/groot-rw' e irão substituir os ficheiros base do jogo a cada execução.

Lembra-se de que a modificação no WINE não é um recurso garantido e depende de como o mod é carregado ou se interfere no WINE. Geralmente, se o mod puder ser carregado através de um iniciador ou diretamente no jogo, deve funcionar.
<br><br>

### Informações Adicionais
Todas as versões são testadas no Arch Linux ou EndeavourOS usando os sistemas de arquivos EXT4, BTRFS ou XFS.
<br><br>

### Biblioteca de Interface Gráfica
Se desejas uma biblioteca de interface gráfica para os teus jogos, consulta a página de [launchers](launchers.md) page.
