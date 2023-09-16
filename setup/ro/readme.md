## jc141 Ghid de configurare

Inca nu ai instalat GNU/Linux sau cauti or recomandare? Incearca [EndeavourOS](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/).

Sugestii pentru schimbari ale repozitoriului pot fi trimise pe [Matrix](https://matrix.to/#/%21aRyMmzPUzcUKRXpVtP%3Amatrix.org?via=catgirl.cloud&via=grin.hu&via=matrix.org).

Programe de emulare virtuala nu sunt suportate.
<br>

### Distributii GNU/Linux Suportate
Te rog sa dai click pe unul dintre urmatoarele link-uri in functie de distributia ta GNU/Linux.

*   [Arch](arch.md) incluzand: Endeavour OS, Arco, Artix, Manjaro si altele.
*   [Debian Sid/Rolling](debian.md) incluzand: Nitrux, Sparky Rolling si Siduction.
*   [NixOS](nixos.md)
*   [Mint](mint.md) incluzand: Pop!_OS
<br>

### Suport pentru hardware
Placa ta video (dedicata/integrata) **trebuie** sa aiba suport pentru Vulkan versiunea 1.3 pentru jocurile ce utilizeaza DXVK, fiind marcate ca start.e-w.sh la fisierul de pornire.

Jocuri cu start.n-w.sh au nevoie de suport Vulkan dar nu neaparat 1.3. Jocuri cu start.n.sh nu au nevoie de suport vulkan in general.

#### [Suport pentru SteamDeck prin Arch](steamdeck/arch.md)
<br>

### Cum sa rulezi jocul
Deschide aplicatia de terminal iar apoi ruleaza urmatoarea comanda. Editeaza unde este necesar.

Atentie! - Utlizarea de sh in loc de bash nu va functiona! Foloseste doar bash sau ./ cu permisiunea x.

```
bash /Locatia/Jocului/start.{n/e-w/n-w}.sh
```

Available environment variables:
```
CACHEPERCENT=15 - Procentul total the RAM (real) care va fi folosit de dwarfs pentru cache. Suma finalata poate fluctua in functie de joc.

DBG=1 - Activeaza afisarea log-urilor in terminal pentru executabil si/sau wine.

WANBLK=0 - Disables WAN blocking which is enabled by default if bindtointerface package is installed.
Dezactiveaza blocarea WAN care este activata in mod implicit daca pachetul bindtointerface este instalat.

UNMOUNT=0 - Disables auto-unmounting of the dwarfs image from 'files/groot'.
Dezactiveaza auto-demontearea unei imagini dwarfs de la 'files/groot'.
```
<br>

### Dwarfs
Fisierul settings.sh contine urmatoarele comenzi optionale ce pot fi uilizate.

```
bash settings.sh COMMANDA

Available Commands (older version)
Comenzi Disponibile (versiunea veche)

  extract (extract-dwarfs)
  unmount (unmount-dwarfs)
  mount (mount-dwarfs)
  delete-image (delete-dwarfs)
  compress (compress-dwarfs)
```
Comanda de extragere va face ca script-ul de pornirea sa foloseasca automat fisierele extrase si nu va incerca sa ruleze montant din nou pana cand fisierul groot este gol sau nu mai exista.
<br><br>

### Modare
Monsteaza jocul cum este prceizat mai sus si adauga fisierele in 'files/groot'. 

Aceste fisiere vor fi salvate in directoriul 'files/groot-rw' si vor trece peste fisierele de baza ale jocului la fiecare rulare.

Ia in considerare ca modarea prin Wine nu este garantata si depinde cum se incarca modul si daca interfereaza cu Wine. In general daca modul poate fi incarcat printr-un lansator sau direct din joc, ar trebui sa fie in regula.
<br><br>

### Informatii aditionale
Toate jocurile au fost testate pe Arch Linux sau EndeavourOS utilizand sistemul de fisiere EXT4, BTRFS sau XFS.
<br><br>

### Librarie GUI
Daca doresti sa folosesti o librarie GUI pentru jocurile tale, vezi pagina [lansatoare](launchers.md).
