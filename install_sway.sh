#!/bin/bash

# Cowboy in the latest version because Ubuntu package is wildly behind

#Install Prerequisites
sudo apt update
sudo apt install -y meson libwayland-dev wayland-protocols libxkbcommon-dev libcairo2-dev libgdk-pixbuf-2.0-dev libpam0g-dev scdoc git
sudo apt install -y build-essential cmake meson ninja-build libwayland-dev libegl1-mesa-dev libgbm-dev libxkbcommon-dev libx11-dev libinput-dev libudev-dev libdrm-dev libpixman-1-dev libpcre2-dev
sudo apt install -y libxml2-dev libdrm-dev graphviz doxygen xsltproc xmlto libjson-c-dev libpango1.0-dev libgtk-3-dev check


mkdir /tmp/swaybuild
cd /tmp/swaybuild

pip3 install --upgrade pip
pip3 install --upgrade meson

#Install libxkbcommon
git clone https://github.com/xkbcommon/libxkbcommon.git
cd libxkbcommon
meson setup build -Denable-x11=false -Dxkb-config-root=/usr/share/X11/xkb -Dx-locale-root=/usr/share/X11/locale
meson compile -C build
sudo ninja -C build install
cd ../

#Install libdrm
git clone https://gitlab.freedesktop.org/mesa/drm.git
cd drm
meson build
sudo ninja -C build install
cd ../

#Install libinput
git clone https://gitlab.freedesktop.org/libinput/libinput.git
cd libinput
meson build
sudo ninja -C build install
cd ../

##Install wayland
#git clone https://gitlab.freedesktop.org/wayland/wayland
#cd wayland
#meson build/ 
#sudo ninja -C build/ install



#Install Sway
git clone https://github.com/swaywm/sway.git
cd sway
git checkout 1.10-rc2
mkdir subprojects

cat > subprojects/wlroots.wrap << EOF
[wrap-git]
url = https://gitlab.freedesktop.org/wlroots/wlroots.git
revision = 0.18.1
EOF

cat > subprojects/wayland.wrap << EOF
[wrap-git]
url = https://gitlab.freedesktop.org/wayland/wayland.git
revision = main
EOF


cat > subprojects/libdrm.wrap << EOF
[wrap-git]
url = https://gitlab.freedesktop.org/mesa/drm.git
revision = main
EOF

cat > subprojects/pixman.wrap << EOF
[wrap-git]
url = https://gitlab.freedesktop.org/pixman/pixman.git
revision = master
EOF

cat > subprojects/wayland-protocols.wrap << EOF
[wrap-git]
url = https://gitlab.freedesktop.org/wayland/wayland-protocols.git
revision = main
EOF

cat > subprojects/libxkbcommon.wrap << EOF
[wrap-git]
url = https://github.com/xkbcommon/libxkbcommon.git
revision = master
EOF


meson build
ninja -C build
sudo ninja -C build/ install


#Install swaylock
cd ../
git clone https://github.com/swaywm/swaylock.git
cd swaylock
meson build
ninja -C build
sudo ninja -C build/ install
echo "/usr/local/lib/x86_64-linux-gnu" | sudo tee /etc/ld.so.conf.d/local-lib.conf
sudo ldconfig
cd ../

#Install swayidle
git clone https://github.com/swaywm/swayidle.git
cd swayidle
meson build
ninja -C build
sudo ninja -C build install
