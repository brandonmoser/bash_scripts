#!/usr/bin/env bash

PYCHARM_VER="pycharm-professional-4.5.2"
DOWNLOAD_LINK="https://download.jetbrains.com/python/$PYCHARM_VER.tar.gz"
DOWNLOAD_DIR="/home/brandonmoser/Downloads"
SCRIPTS_DIR="$(pwd)"
INSTALL_DIR="/opt/pycharm"
PYCHARM_BIN="$INSTALL_DIR/bin"


# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

download_pycharm() {
    echo "-------------------------------------------"
    cd $DOWNLOAD_DIR
    if [ ! -f "$DOWNLOAD_DIR/$PYCHARM_VER.tar.gz" ]; then
        echo "Downloading to $DOWNLOAD_DIR "
        wget $DOWNLOAD_LINK -O $PYCHARM_VER.tar.gz
        chown brandonmoser:brandonmoser $PYCHARM_VER.tar.gz
    else
        echo "$PYCHARM_VER.tar.gz exists, skipping download "
    fi
    echo ""
}

extract_pycharm() {
    echo "Extracting... "
    echo "-------------------------------------------"
    cd $DOWNLOAD_DIR
    tar -xzf $PYCHARM_VER.tar.gz
    mv pycharm-4.5.2/ pycharm/

    if [ -d $INSTALL_DIR ]; then
        mv $INSTALL_DIR/ /opt/pycharm-old/
    fi
    mv pycharm/ $INSTALL_DIR
    echo ""
}

fix_vmoptions() {
    echo "Updating VMOptions "
    echo "-------------------------------------------"
    rm -f $PYCHARM_BIN/pycharm.vmoptions
    rm -f $PYCHARM_BIN/pycharm64.vmoptions
    ln -s $SCRIPTS_DIR/pycharm.vmoptions $PYCHARM_BIN/pycharm.vmoptions
    ln -s $SCRIPTS_DIR/pycharm64.vmoptions $PYCHARM_BIN/pycharm64.vmoptions
    echo ""
}

clear
echo "===================================================="
echo "| Installing $PYCHARM_VER                          |"
echo "===================================================="
echo ""

download_pycharm
extract_pycharm
fix_vmoptions

echo "DONE. Run the application the first time here: ``\$ $PYCHARM_BIN/pycharm.sh``"