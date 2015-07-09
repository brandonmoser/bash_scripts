#!/usr/bin/env bash
clear

# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# 1. Add Yorba PPA
sudo add-apt-repository ppa:yorba/ppa

# 2. Update Apt Repos
sudo apt-get update

# 3. Install Geary
sudo apt-get install geary shotwell

exit 0