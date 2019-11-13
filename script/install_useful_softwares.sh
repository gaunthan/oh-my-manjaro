#!/usr/bin/env bash

# This script will install some basic softwares such as web browser,
#   fonts, office toolkit, programming IDE and so on.

# Upgrade system first before installation to avoid strange problems
sudo pacman -Syyu

# Now install useful softwares
sudo pacman -S --noconfirm \
    google-chrome wps-office netease-cloud-music shadowsocks-qt5 \
    code tilix octave \
    wqy-bitmapfont wqy-microhei wqy-zenhei ttf-wps-fonts