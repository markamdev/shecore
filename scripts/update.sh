#!/bin/bash

echo "SHEll COnfig REstorer update script"
echo ""

INSTALL_DIR=$HOME/.mkd

ALIASES_SH=$INSTALL_DIR/scripts/aliases.sh
ALIASES_DATA=$INSTALL_DIR/aliases.source
VARS_SH=$INSTALL_DIR/scripts/variables.sh
VARS_DATA=$INSTALL_DIR/variables.source
TOOLS_SH=$INSTALL_DIR/scripts/utils.sh


# all sub-scripts should already exists but sanity check is always a good idea
if [[ ! -f $ALIASES_SH || ! -f $VARS_SH || ! -f $TOOLS_SH ]];
then
    echo "Unable to found necessary tools - please reinstall"
    echo "> $ALIASES_SH | $VARS_SH | $TOOLS_SH <"
    exit 1
fi

. $TOOLS_SH
. $ALIASES_SH
. $VARS_SH

# add common aliases
add_aliases $ALIASES_DATA $INSTALL_DIR

# set environment variables
set_variables $VARS_DATA $INSTALL_DIR

# finished
echo ""
echo "All update tasks finished"
echo "Reload terminal or source '$INSTALL_DIR/shecore.env' file"

exit 0
