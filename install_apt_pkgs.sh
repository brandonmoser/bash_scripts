#!/usr/bin/env bash
clear

# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

sudo apt-get install git git-extras wget corebird meld filezilla firefox vim gksu \
                    indicator-stickynotes nodejs pgadmin3 postgresql redis-server \
                    remmina y-ppa-manager dconf-editor

exit 0