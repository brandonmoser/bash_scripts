#!/usr/bin/env bash
clear

# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# You can add the repository key to apt. Keep in mind that the owner of the key may distribute updates, packages and
# repositories that your system will trust (more information). To add the key, run:
wget -qO- http://download.opensuse.org/repositories/home:olav-st/xUbuntu_14.04/Release.key | sudo apt-key add -

# For xUbuntu 14.04 run the following:
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/olav-st/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/screencloud.list"
sudo apt-get update
sudo apt-get install screencloud

exit 0