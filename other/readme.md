native steamclient
```sh
mkdir -p "$PWD/files/data/.steam/sdk64" && cp "$PWD/files/steamclient.so" "$PWD/files/data/.steam/sdk64/steamclient.so" && cp -r "$PWD/files/steam_settings" "$PWD/files/data/.steam/sdk64/" && echo $BASHPID > "$PWD/files/data/.steam/steam.pid"
# or
mkdir -p "$PWD/files/data/.steam/sdk32" && cp "$PWD/files/steamclient.so" "$PWD/files/data/.steam/sdk32/steamclient.so" && cp -r "$PWD/files/steam_settings" "$PWD/files/data/.steam/sdk32/" && echo $BASHPID > "$PWD/files/data/.steam/steam.pid"
cd "$BINDIR";
SteamAppId=594570 SteamGameId=594570 ./"$BIN"
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
