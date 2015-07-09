#!/usr/bin/env bash
clear

CHROME="google-chrome-stable_current_amd64.deb"
DOWNLOAD_LINK="https://dl.google.com/linux/direct/$CHROME"
DOWNLOAD_DIR="/home/brandonmoser/Downloads"
SCRIPTS_DIR="$(pwd)"

# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

download_chrome_deb() {
    echo "-------------------------------------------"
    cd $DOWNLOAD_DIR
    wget $DOWNLOAD_LINK -O $CHROME
    echo ""
}

install_chrome() {
    echo "Extracting... "
    echo "-------------------------------------------"
    cd $DOWNLOAD_DIR
    sudo dpkg -i $CHROME
    echo ""
}

fix_dependencies() {
    echo "Updating Dependencies "
    echo "-------------------------------------------"
    sudo apt-get --yes --fix-broken install
    echo ""
}

echo "===================================================="
echo "| Installing Chrome                                |"
echo "===================================================="
echo ""
if [ ! -f "$CHROME" ]; then
    echo "Downloading to $DOWNLOAD_DIR "
    download_chrome_deb
else
    echo "$CHROME exists, skipping downloads "
    echo ""
fi
install_chrome
fix_dependencies
echo "DONE"
exit 0