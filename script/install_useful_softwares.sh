#!/usr/bin/env bash

# This script will install some basic softwares such as web browser,
#   fonts, office toolkit, programming IDE and so on.

# Upgrade system first before installation to avoid strange problems
sudo pacman -Syyu

# Now install useful softwares
sudo pacman -S --noconfirm \
    google-chrome wps-office netease-cloud-music shadowsocks-qt5 \
    code tilix octave zeal bash-completion \
    wqy-bitmapfont wqy-microhei wqy-zenhei ttf-wps-fonts

# Install fcitx input method
sudo pacman -S --noconfirm \
    fcitx fcitx-im fcitx-configtool fctix-rime

# Setup config file for fcitx
CONFIG_FILE=/etc/environment
grep "GTK_IM_MODULE" $CONFIG_FILE -q
if [[ "$?" != "0" ]]; then
    echo "
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=\"@im=fcitx\"" | sudo tee -a $CONFIG_FILE
fi
