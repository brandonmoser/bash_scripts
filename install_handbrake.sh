#!/usr/bin/env bash
clear

# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# 1. Add the Handbrake repository signing key to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 30CC05C8

# 2. Add the Spotify repository
if [ ! -f "/etc/apt/sources.list.d/handbrake.list" ]; then
    echo -e "deb http://ppa.launchpad.net/stebbins/handbrake-releases/ubuntu trusty main\n# deb-src http://ppa.launchpad.net/stebbins/handbrake-releases/ubuntu trusty main" | sudo tee /etc/apt/sources.list.d/handbrake.list
fi

# 3. Update list of available packages
sudo apt-get update

# 4. Install Spotify
sudo apt-get install handbrake-gtk handbrake-cli

exit 0