#!/bin/sh
# Example: https://github.com/cstrap/monaco-font#install-monaco-font-on-ubuntu
# Reference: https://github.com/adobe-fonts/source-code-pro/issues/17#issuecomment-8967116

INSTALL_LOC="user"
INSTALL_DIR="~/.fonts/adobe-fonts/source-code-pro"
REPO="https://github.com/adobe-fonts/source-code-pro.git"

if [ $1 = "system" ]; then
    INSTALL_DIR="/usr/share/fonts/adobe-fonts/source-code-pro"
fi

echo "installing fonts at $REPO to $INSTALL_DIR"
mkdir -p $INSTALL_DIR
git clone $REPO $INSTALL_DIR

# find ~/.fonts/ -iname '*.ttf' -exec echo \{\} \;

if [ $1 = "system" ]; then
    sudo fc-cache -f -v $INSTALL_DIR
else
    fc-cache -f -v $INSTALL_DIR
fi

echo "finished installing font"