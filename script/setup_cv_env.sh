#!/usr/bin/env bash

# This script is for those who working on computer vision task.

# Install basic tools & libs
sudo pacman -S --noconfirm base-devel cmake gdb

# Install OpenCV
sudo pacman -S --noconfirm opencv vtk hdf5

# Install Anaconda (Python Scientific Computing Environment)
sudo pacman -S --noconfirm anaconda
/opt/anaconda/bin/conda init
