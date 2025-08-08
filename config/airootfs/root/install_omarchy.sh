#!/bin/bash

export OMARCHY_BARE=true
export OMARCHY_NOREBOOT=true
export OMARCHY_REPO="PaulFinch/Omarchy"

USER=$(getent passwd 1000 | cut -d: -f1)

wget -qO- https://raw.githubusercontent.com/basecamp/omarchy/refs/heads/master/boot.sh | sudo --preserve-env=OMARCHY_BARE,OMARCHY_NOREBOOT,OMARCHY_REPO -u "${USER}" -g "${USER}" -- bash
if [ $? -eq 0 ]; then
    # Set the Repo back to the Original
    sudo -u "${USER}" -g "${USER}" -- git -C "/home/${USER}/.local/share/omarchy" remote set-url origin "https://github.com/basecamp/omarchy.git"
    sudo -u "${USER}" -g "${USER}" -- git -C "/home/${USER}/.local/share/omarchy" pull
    exit 0
fi

exit 1