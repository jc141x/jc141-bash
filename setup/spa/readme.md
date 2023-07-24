## jc141 Guía de Configuración

Aún no has instalado GNU/Linux o buscas recomendaciones? Prueba [EndeavourOS](https://discovery.endeavouros.com/installation/create-install-media-usb-key/2021/03/).

Sugerencias sobre cualquier cambio a este repositorio son bienvenidas en [Matrix](https://matrix.to/#/%21aRyMmzPUzcUKRXpVtP%3Amatrix.org?via=catgirl.cloud&via=grin.hu&via=matrix.org).

No damos soporte para Máquinas Virtuales.
<br>

### Distribuciones de GNU/Linux soportadas
Por favor, haz click en alguno de los siguientes enlaces para configurar tu distribución de GNU/Linux.

*   [Arch](arch.md) incluye: Endeavour OS, Arco, Artix, Manjaro y otras.
*   [Debian Sid/Rolling](debian.md) incluye: Nitrux, Sparky Rolling y Siduction.
*   [Fedora](fedora.md) incluye: Rawhide.
*   [NixOS](nixos.md)
*   [Mint](mint.md) incluye: Pop!_OS, KDE Neon, Elementary OS
<br>

### Soporte de Hardware
Tu hardware de gráficos (GPU/APU) **necesita** tener soporte para Vulkan 1.3 en lanzamientos que usan DXVK y VKD3D, marcados como start.e-w.sh en el script de inicio.

Lanzamientos con start.n-w.sh necesitan soporte para Vulkan pero no necesariamente 1.3. Lanzamientos con start.n.sh por lo general no requieren soporte para Vulkan.

#### [Soporte para SteamDeck con Arch](steamdeck/arch.md)
<br>

### Cómo ejecutar los Juegos
Abre una terminal y luego ejecuta el siguiente comando. Por favor haz los cambios apropiados.

PRECAUCIÓN! - Usar sh en vez de bash no funciona! Usa únicamente bash o ./ con permiso x.

```
bash /Ruta/hacia/Juego/start.{n/e-w/n-w}.sh
```

Variables de entorno disponibles:
```
CACHEPERCENT=15 - Porcentaje del total de RAM física disponible para dwarfs como caché. Valores más altos se traducen en más fluidez (no implica cambios dramáticos si se incrementa más allá de 15). 15% es el valor por defecto.

DBG=1 - Activa la salida a la terminal del output del binaro y/o wine.

WANBLK=0 - Desactiva el bloqueo de WAN, el cual está activado por defecto si se ha instalado el paquete bindtointerface.

UNMOUNT=0 - Desactiva el desmontado automático de la imagen dwarfs de 'files/groot'.
```
<br>

### Dwarfs
El archivo settings.sh proporciona algunos comandos opcionales que pueden ser de utilidad.

```
bash settings.sh COMANDO

Comandos disponibles (versión vieja)
  extract (extract-dwarfs)
  unmount (unmount-dwarfs)
  mount (mount-dwarfs)
  delete-image (delete-dwarfs)
  compress (compress-dwarfs)
```
El comando de extracción se encargará de que el script de inicio use los archivos extraídos y no intentará ejecutarse montado a menos que el directorio groot vuelva a eliminarse o vaciarse (si el script monta por defecto).
<br><br>

### Modding
Es posible añadir mods usando el directorio `files/groot-rw`. Agrega los archivos directamente ahí, o monta los archivos del juego como se explica arriba, o edita los archivos en el directorio 'files/groot'.

Estos archivos serán guardados en el directorio 'files/groot' y sobreescribiran a los archivos del juego base en cada ejecución.

Recuerda que el modding en Wine no está garantizado de funcionar, ya que depende de la forma en que el mod se carga o de que interfiera con wine. Generalmente, si el mod se puede cargar mediante un lanzador o directamente desde el juego, no deberían haber problemas.
<br><br>

### Información Adicional
Todos nuestros lanzamientos se prueban en Arch Linux o EndeavourOS con sistemas de archivos EXT4, BTRFS o XFS.
<br><br>

### Biblioteca con GUI
Si quieres una interfaz gráfica para organizar nuestros juegos, revisa la página [launchers](launchers.md).
