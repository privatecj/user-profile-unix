#!/bin/bash
echo "Starting BASH SHELL"

## Detect current script location and user name 
SCRIPT_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Script Root DIR: "$SCRIPT_ROOT_DIR
ADDUSER="${ADDUSER:-cj}"
echo "As User: "$ADDUSER
echo ""

if [[ $OSTYPE == "linux-gnu" ]]; then
    bash $SCRIPT_ROOT_DIR/install-linux-profile.sh
fi