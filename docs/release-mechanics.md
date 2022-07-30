### game files

groot.dwarfs is created with the -l7 -B30 settings. This means it uses zstd level 22 with block size 30.

The game will usually mount groot.dwarfs to files/groot-mnt and then overlay to groot. Files created by the game, wine or other programs are created in groot and then stored in groot-rw (if with wine then also files/data/user-data). On next mounting groot-rw will overlay above groot and provide the mentioned files.

### wineprefix and rumtricks

Location: .local/rumtricks

The standard is that rumtricks-content will be downloaded and extracted then deleted. rumtricks will create a prefix which will include directx and all vcrun versions. The prefix is then compressed to prefix.dwarfs with zstd and deleted.

Creating prefix.dwarfs happens only when it did not exist or when the dwarfs image is older than 60 days. (to prevent incompatibilities with future wine versions)

On each run, prefix.dwarfs is mounted to prefix-mnt and overlayed to files/data/prefix-tmp. Files created by the game or wine are stored in files/data/user-data.

### closing and automated unmounting

The start script is defaulted to unmount game files and on wine also prefix after the game binary/exe stopped running. There can be cases where zombie processes exist and unmounting is postponed or never happens without user input. bash dwarfsettings.sh unmount-game and unmount-prefix can be used.

### native isolation

The majority of native games will be isolated from user home directory with following variables being exported: HOME, XDG_DATA_HOME, XDG_CONFIG_HOME. Data created is stored in files/data. Some games may still create files in real home without our knowledge.

### gamescope

It is supported by default where testing showed proper gameplay (no display or input issues, crashes). It provides isolation from display server and ability to force resolution as well as FSR.
