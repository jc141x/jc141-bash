<div align="center">
  <h1>Setup Guide - openSUSE Tumbleweed</h1>
</div>

### DWARFS
Read the [following](https://build.opensuse.org/package/show/home:dsme/dwarfs).

Also needed:
```sh
sudo zypper install fuse-overlayfs
```

#### ZPAQ.
```sh
sudo zypper install zpaq
```

#### AMD graphics packages
```sh
sudo zypper install vulkan-loader vulkan libvulkan1 vulkan-utils mesa-vulkan-drivers
```

#### Wine-staging and other libraries
```sh
sudo zypper install wine-staging giflib-devel gstreamer-plugins-ugly gstreamer-plugins-libav gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-base gstreamer-plugins-ugly-32bit gstreamer-plugins-libav-32bit gstreamer-plugins-good-32bit gstreamer-plugins-bad-32bit gstreamer-plugins-base-32bit jq giflib-32bit gnutls-32bit libjpeg-turbo libldap-2_4-2 libldap-2_4-2-32bit libpng16-16 libpng16-16-32bit libXcomposite libXcomposite1-32bit libXinerama1 libXinerama1-32bit libxslt libxslt1-32bit libmpg123-0 libmpg123-0-32bit ocl-icd libSDL2-2_0-0-32bit libSDL2-2_0-0-32bit v4l-utils libgphoto2-6-32bit libgphoto2 libxslt1-32bit libxslt libz1
```

#### Audio drivers
```sh
sudo zypper install alsa fluidsynth alsa-utils libopenal1-32bit libpulse0-32bit
```

#### Yuzu
```sh
export API_URL="https://api.github.com/repos/yuzu-emu/yuzu-mainline/releases/latest" && export DOWNLOAD_URL=$(curl -s $API_URL | grep -oP '"browser_download_url": "\K(.*AppImage)(?=")') && curl -Lo /tmp/yuzu --progress-meter $DOWNLOAD_URL && chmod +x /tmp/yuzu && sudo mv /tmp/yuzu /usr/local/bin/yuzu
```