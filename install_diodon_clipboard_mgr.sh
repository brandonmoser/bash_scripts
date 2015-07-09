#!/usr/bin/env bash
clear

# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# 1. Add the Diodon repository
sudo apt-add-repository ppa:diodon-team/stable

# 2. Update list of available packages
sudo apt-get update

# 3. Install Diodon
sudo apt-get install diodon

# and for all Unity users there is also a scope
sudo apt-get install unity-scope-diodon