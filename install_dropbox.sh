#!/usr/bin/env bash

# Download the Linux x64 version
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -

# Run the daemon
~/.dropbox-dist/dropboxd &

# Echo that a control script is available
echo "=============================================="
echo "A control script is available here"
echo "$ python dropbox.py"
echo "with no arguments, usage will be displayed."
echo "=============================================="

exit 0