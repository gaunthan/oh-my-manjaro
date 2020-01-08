#!/usr/bin/env bash

# This script will enable China mirrors and add archlinuxcn, antergos repos.
# Chinese users are recommended to use.

# Use China mirrors
sudo pacman-mirrors -c China

# Add archlinuxcn & antergos repo

# Usage:
#   add_repo_if_not_exist <repo_name> <sig_level> <server>
add_repo_if_not_exist()
{
    CONFIG_FILE=/etc/pacman.conf

    repo_name=$1
    sig_level=$2
    server=$3

    content="
[$repo_name]
SigLevel = $sig_level
Server = $server"

    grep "\[$repo_name\]" $CONFIG_FILE -q
    if [[ "$?" == "0" ]]; then
        echo "Repo $repo_name already exist, skipped"
        return
    fi

    echo "Adding following content to $CONFIG_FILE:"
    echo "$content" | sudo tee -a $CONFIG_FILE
}

add_repo_if_not_exist "archlinuxcn" "TrustAll" \
                      'https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch'

add_repo_if_not_exist "antergos" "TrustAll" \
                      'https://mirrors.tuna.tsinghua.edu.cn/antergos/$repo/$arch'

# Update source
sudo pacman -Syy
