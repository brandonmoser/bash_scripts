#!/usr/bin/env bash
clear

# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

sudo apt-get install -y git git-extras wget meld filezilla firefox vim gksu \
	nodejs pgadmin3 postgresql redis-server remmina dconf-editor

exit 0
