## Průvodce jc141

Ještě jste nenainstalovali GNU/Linux nebo hledáte doporučení? Zkuste [EndeavourOS](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/).

Nápady nebo změny pro tento repozitář jsou vítány na [Matrixu](https://matrix.to/#/%21aRyMmzPUzcUKRXpVtP%3Amatrix.org?via=catgirl.cloud&via=grin.hu&via=matrix.org).

Virtuální jednotky nejsou podporovány.
<br>

### Podporované GNU/Linux distribuce.
Klikněte na jeden z níže uvedených odkazů pro nastavení vaší GNU/Linux distribuce.

*   [Arch](arch.md) včetně: Endeavour OS, Arco, Artix, Manjaro a dalších.
*   [Debian Sid/Rolling](debian.md) včetně: Nitrux, Sparky Rolling a Siduction.
*   [Fedora](fedora.md) včetně: Rawhide.
*   [NixOS](nixos.md)
*   [Mint](mint.md) včetně: Pop!_OS, KDE Neon, Elementary OS
*   Otázka: Kde je Ubuntu? Odpověď: Nepoužívejte Ubuntu.
<br>

### Podporovaný Hardware
Váš grafický hardware (GPU/APU) **musí** podporovat Vulkan 1.3 pro vydání, která používají DXVK a VKD3D, označena jako start.e-w.sh pro startující skript.

Vydání se start.n-w.sh musí podporovat Vulkan, ale ne nutně 1.3. Vydání se start.n.sh obecně nevyžadují podporu Vulkanu.

#### [Podpora SteamDecku na Arch Linuxu](steamdeck/arch.md)
<br>

### Jak spustit hru
Otevřete terminál a zadejte následující příkaz. Prosím upravte, kde to je nutné.

VAROVÁNÍ! - Používání sh namísto bash nefunguje! používejte jenom bash nebo ./ s oprávněním spuštění.

```
bash /Cesta/ke/hře/start.{n/e-w/n-w}.sh
```

Dostupné možnosti prostředí:
```
CACHEPERCENT=15 - Procento celkové hardwarové paměti (RAM) pro použití dwarfs jako umístění dočasných souborů (cache). Více znamená lepší hladkost (není nutně poznatelné pokud zvýšeno více). 15% je výchozí.

DBG=1 - Zapne terminálový výstup binárního souboru a/nebo wine.

WANBLK=0 - Vypne blokování WAN, které je ve výchozím nastavení zapnuto (jen pokud je nainstalovaný program bindtointerface).

UNMOUNT=0 - Vypne automatické odpojování dwarfs souborů z 'files/groot'.
```
<br>

### Dwarfs
settings.sh soubor poskytuje nějaké volitelné možnosti, které můžou být užitečné.

```
bash settings.sh PŘÍKAZ

Dostupné příkazy (starší verze)
  extract (extract-dwarfs)
  unmount (unmount-dwarfs)
  mount (mount-dwarfs)
  delete-image (delete-dwarfs)
  compress (compress-dwarfs)
```
Příkaz extract automaticky donutí startovací skript používat extrahované soubory namísto těch zkomprimovaných a nebude se pokoušet je znovu připojit, dokud nebude adresář groot prázdný nebo chybějící (pokud skript ve výchozím nastavení připojuje dwarfs).
<br><br>

### Módování
Přidávání módů je podporováno přes adresář `files/groot-rw`. Přidejte do nich soubory přímo, nebo nejdříve připojte hru dle instrukcí výše a přidejte je tam potom.

Tyto soubory budou uloženy do adresáře files/groot-rw a přepíšou soubory hry při každém spuštění.

Mějte na paměti, že módování přes Wine není garantovaná funkce a záleží, jak je mód načten, nebo pokud zasahuje do funkcí Wine. Obecně, pokud může být mód načten do spouštěče nebo přímo ve hře, bude nejspíše fungovat.
<br><br>

### Doplňující informace
Všechna vydání jsou testována na Arch Linuxu nebo Endeavour OS na souborových systémech EXT4, BTRFS nebo XFS.
<br><br>

### Grafická knihovna (GUI)
Pokud byste chtěli spouštět hry graficky, přečtěte si stránku [spouštěče.](launchers.md)
