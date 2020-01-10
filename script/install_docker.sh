#!/usr/bin/env bash

# Install docker
sudo pacman -S docker --noconfirm

# Enable docker on system booting
sudo systemctl enable docker
sudo systemctl start docker

# Add China mirrors if at Asia
curl http://ip-api.com/line?fields=timezone 2> /dev/null | grep -qi Asia
if [[ "$?" = "0" ]]; then
    echo -n "Adding China mirrors..."

    DOCKER_CONFIG_FILE="/etc/docker/daemon.json"

    # Create config file if not exits
    if [[ ! -f ${DOCKER_CONFIG_FILE} ]]; then
        echo {} | sudo tee ${DOCKER_CONFIG_FILE} > /dev/null
    fi

    # Add mirrors
    chmod +x add_docker_mirrors.py
    sudo ./add_docker_mirrors.py ../config/docker-china-mirrors.txt \
            --config_file ${DOCKER_CONFIG_FILE}

    echo "done"
fi

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
