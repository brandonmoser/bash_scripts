#!/usr/bin/env bash

# REF: http://support.code42.com/CrashPlan/Latest/Getting_Started/Installing_The_CrashPlan_App#Linux

DOWNLOAD_FILE="CrashPlan_4.3.0_Linux.tgz"
DOWNLOAD_LINK="https://download2.code42.com/installs/linux/install/CrashPlan/$DOWNLOAD_FILE"
DOWNLOAD_DIR="/home/brandonmoser/Downloads"
EXTRACT_LOC="$DOWNLOAD_DIR/CrashPlan-install"
SCRIPTS_DIR="$(pwd)"

# Make sure only root can run this script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

download_installer() {
    echo "-------------------------------------------"
    if [ ! -f "$DOWNLOAD_DIR/$DOWNLOAD_FILE" ]; then
        echo "Downloading to $DOWNLOAD_DIR "
        cd $DOWNLOAD_DIR
        wget $DOWNLOAD_LINK -O $DOWNLOAD_FILE
    else
        echo "$DOWNLOAD_FILE exists, skipping downloads "
        echo ""
    fi
    echo ""
}

extract_file() {
    echo "-------------------------------------------"
    echo "Extracting... "
    cd $DOWNLOAD_DIR
    tar -xzf $DOWNLOAD_FILE
    echo ""
}

run_installer() {
    echo "-------------------------------------------"
    echo "Run installer "
    $EXTRACT_LOC/install.sh
    echo ""
}

clear
echo "===================================================="
echo "| Installing $DOWNLOAD_FILE                          |"
echo "===================================================="
echo ""

download_installer
extract_file
run_installer

echo "DONE"
