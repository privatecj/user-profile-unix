#!/bin/bash

echo ""
echo "==================================="
echo "  setting up your shell $(whoami)"
echo "==================================="
echo ""
echo ""
echo ""


neofetch --ascii_distro manjaro
export SCRIPT_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# source all alias
for f in $SCRIPT_ROOT_DIR/alias/*.sh; do source $f; done

# add execute permission to all scripts
for file in "$(find $SCRIPT_ROOT_DIR"/install" -maxdepth 10 -name '*' -print)"; do chown -R $(whoami) $file; done

# add all script dirs to path
PATH=$PATH$( find $SCRIPT_ROOT_DIR"/install" -type d -printf ":%p" )
export PATH


# source $SCRIPT_ROOT_DIR"/common/start-ssh-agent.sh"
# source $SCRIPT_ROOT_DIR"/common/add-all-ssh-keys.sh"