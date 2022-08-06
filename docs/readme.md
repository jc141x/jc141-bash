### game files

- groot.dwarfs is created with the -l7 -B30 settings. This means it uses zstd level 22 with block size 30.

- the script will usually mount groot.dwarfs to files/groot-mnt and then overlay to groot (unless it is configured to be extracted). 

- files created by the game, wine or other programs are created in groot and then stored in groot-rw (if with wine then also files/data/user-data). On next mounting groot-rw will overlay above groot and provide the mentioned files.

---------------------------------------------------------------------------

### script header code

- both the native games and wine-wrapped games make usage of this code in the first 3 lines of the scripts.

``` sh
[ ! -x "$(command -v dwarfs)" ] && echo "dwarfs not installed" && exit; [ ! -x "$(command -v fuse-overlayfs)" ] && echo "fuse-overlayfs not installed" && exit
```
- with conditions `-x` is a condition that a file exists and is executable. `!` Means NOT. So what these commands do is check if dwarfs and fuse-overlayfs don't exist and are not executable, then output that the dependencies (dwarfs and overlayfs are not installed).

<br>

```sh
cd "$(dirname "$(readlink -f "$0")")" || exit;
```

- change directory to the script's directory or exit.

<br>

```sh
[ "$EUID" = "0" ] && exit;
```

- exit if the script is run with root privilidge (sudo).

<br>

```sh
R="$PWD"; DWRF="$R/dwarfsettings.sh";
``` 
- shorten some commonly referenced variables. 

----------------------------------------------------------------------------

### custom native conditions

- the majority of native games will be isolated from user home directory. Some games may still create files in real home without our knowledge.

- the following makes and defines the XDG variables for the script (~/.config and ~/.local) as folders in the files/data directory. This isolates the progams file sprawl to within the game folder and allows the game to be portable.

```sh
export XDG_DATA_HOME="$R/files/data/.local"; 
export XDG_CONFIG_HOME="$R/files/data/.config"; 
mkdir -p {"$HOME","$XDG_CONFIG_HOME","$XDG_DATA_HOME"}
```

-------------------------------------------------------------------------------

### custom wine conditions

```sh
bash "$DWRF" mount-prefix
```

- on first run ever, rumtricks-content will be downloaded and extracted then deleted. rumtricks will create a prefix which will include directx and all vcrun versions. The prefix is then compressed to prefix.dwarfs with zstd and deleted. Location: .local/share/rumtricks

- creating prefix.dwarfs happens only when it did not exist or when the dwarfs image is older than 60 days. (to prevent incompatibilities with future wine versions)

- on each run, prefix.dwarfs is mounted to prefix-mnt and overlayed to files/data/prefix-tmp.

<br>

```sh
export WINEPREFIX="$PWD/files/data/prefix-tmp"; 
```

- exports a temporary path for wineprefix which is overlayed from ./local/share/rumtricks/prefix-mnt

<br>

```sh
# WINE handler (choices: wine-tkg, wine-ge, wine-tkg-nomingw)
_WINE="wine-tkg"; bash "$WHA" "$_WINE"; 
[ -x "$BINDIR/wine/bin/wine" ] && export WINE="$BINDIR/wine/bin/wine" || export WINE="$(command -v wine)"; 
```

- checks if wine-tkg is installed on system, then uses it if it does or otherwise downloads and extracts it to $BINDIR

<br>

```sh
  # rumtricks
bash "$RMT" dxvk
```

- custom modifications to wineprefix such as vulkan translation layers or providing special dependencies.

-----------------------------------------------------------------------------------

### paths and conditions

```sh
BINDIR="$R/files/groot";
```

- the diectory where the game binary is located.

<br>

```sh
BIN="game.bin";
``` 

- the name of the game binary.

<br>

```sh
CMD=(./"$BIN")
``` 

- define the game launch command without gamescope.

<br>

```sh
CMD=("$WINE" "$BIN");
``` 

- define the game launch command without gamescope on wine.

<br>

```sh
: ${GAMESCOPE:=$(command -v gamescope)}
``` 

- allows for gamescope to be toggled on script run (GAMESCOPE=1 bash start.n.sh).

<br>

```sh
[ -x "$GAMESCOPE" ] && CMD=("$GAMESCOPE" -f -- "${CMD[@]}");
```

- if gamescope exists and is executable, set the launch command to launch the game with gamescope

--------------------------------------------------------------------------------------


### dwarfs usage

```sh
bash "$DWRF" mount-game
```
- call the function "mount-game" from the dwarfsettings, wine mount-prefix is also called.

<br>

```sh
function cleanup { cd "$OLDPWD" && bash "$DWRF" unmount-game; }
```

- cleanup is a function that changes directory back to start script directory and calls "unmount-game"
function from dwarfsettings. If the game is using wine prefix also needs to be unmounted.

<br>

```sh
trap 'cleanup' EXIT INT SIGINT SIGTERM
``` 

- will call cleanup function if the game exits or crashes.

- there can be cases where zombie processes exist and unmounting is postponed or never happens without user input. 

---------------------------------------------------------------------------------------------

### final run command

```sh
[ "${DBG:=0}" = "1" ] || exec &>/dev/null
```
- if The user didnt specify DBG=1 Then send all output messages to the void.

<br>

```sh
cd "$BINDIR"; "${CMD[@]}" "$@"
```` 
- change directory to the directory where the game binary is and execute the launch command defined previously.
