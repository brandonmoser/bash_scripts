#!/usr/bin/env bash
clear

#http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_amd64.deb
BUILD="3083"
echo $BUILD

DEB_PKG="sublime-text_build-$BUILD_amd64.deb"
DOWNLOAD_LINK="http://c758482.r82.cf2.rackcdn.com/$DEB_PKG"
DOWNLOAD_DIR="~/Downloads"
SCRIPTS_DIR="$(pwd)"

# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

download_deb_pkg() {
    echo "-------------------------------------------"
    cd $DOWNLOAD_DIR
    wget $DOWNLOAD_LINK -O $DEB_PKG
    echo ""
}

install_application() {
    echo "Extracting... "
    echo "-------------------------------------------"
    cd $DOWNLOAD_DIR
    sudo dpkg -iE $DEB_PKG
    echo ""
}

fix_dependencies() {
    echo "Updating Dependencies "
    echo "-------------------------------------------"
    sudo apt-get --yes --fix-broken install
    echo ""
}

echo "===================================================="
echo "| Installing Sublime Text 3 build $BUILD           |"
echo "===================================================="
echo ""
if [ ! -f "$DEB_PKG" ]; then
    echo "Downloading to $DOWNLOAD_DIR "
    download_deb_pkg
else
    echo "$DEB_PKG exists, skipping downloads "
    echo ""
fi
install_application
fix_dependencies
echo "DONE"
exit 0
