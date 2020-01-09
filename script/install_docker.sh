#!/usr/bin/env bash

# Install docker
sudo pacman -S docker --noconfirm

# Enable docker on system booting
sudo systemctl enable docker
sudo systemctl start docker

# Create docker group if not exists
GROUP="docker"
grep -q ${GROUP} /etc/group
if [[ "$?" != "0" ]]; then
    sudo groupadd ${GROUP}
fi

# Add current user to docker group
sudo usermod -aG ${GROUP} ${USER}

# Restart docker to make anything effect
sudo systemctl restart docker

# Check if need to log out
id | grep -q ${GROUP}
if [[ "$?" = "0" ]]; then
    echo "Congrads! Now you are able to use docker commands."
else
    echo "Oops! You may need to log out and log back in again"\
	 "to be able to run docker commands!"
    echo "If it still doesn't work, you may need to reboot your system!"
fi
