extract instead of mount on start
```sh
[ ! -d "$PWD/files/groot" ] && echo "Extracting game root..."; mkdir "$PWD/files/groot" && dwarfsextract -i "$PWD/files/groot.dwarfs" -o "$PWD/files/groot"
```

native steamclient
```sh
mkdir -p $HOME/.steam/sdk64 && cp steamclient.so $HOME/.steam/sdk64/steamclient.so && cp -r steam_settings ~/.steam/sdk64/ && echo $BASHPID > $HOME/.steam/steam.pid
# or
mkdir -p $HOME/.steam/sdk32 && cp steamclient.so $HOME/.steam/sdk32/steamclient.so && cp -r steam_settings ~/.steam/sdk32/ && echo $BASHPID > $HOME/.steam/steam.pid

[ ! -x "$GAMESCOPE" ] && exec env SteamAppId=000000 SteamGameId=000000 "$BIN" "GAME" && rm -rf "$HOME/.steam" || exec env SteamAppId=000000 SteamGameId=000000 gamescope -f -- "$BIN" "GAME" && rm -rf "$HOME/.steam"
```

sed array
```sh
sed -i "9s/.*/Resolution $RESOLUTION/" "foo.txt" 

# array use
LIST=(5 16 17 18 19 37 39 44)

for i in "${LIST[@]}"; do
sed -i "${i}s+/+\\\\\\\+g" "foo.txt"
done
```

add entries to registry
```sh
echo '

[Software\\Wow6432Node\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\Uplay] 1629462334
#1111' | tee -a /file
```

fluidsynth
```sh
# Put soundfont file in 'game' directory
FLUIDSYNTH="$(command -v fluidsynth 2>/dev/null)"; FLUIDSYNTH_BACKEND="pulseaudio"
[ -n "$FLUIDSYNTH" ] && FLUIDSYNTH_PID=$(nohup fluidsynth -a $FLUIDSYNTH_BACKEND -m alsa_seq -s -i "$PWD/files/soundfont.sf2" > /dev/null 2>&1 & echo $!) || echo "FluidSynth not set up, MIDI tracks (in-game music) won't play."

## Kill FluidSynth instance when game exits/crashes
trap 'kill -9 $FLUIDSYNTH_PID 2>/dev/null' EXIT SIGINT SIGTERM
```
