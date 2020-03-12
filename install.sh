#!/bin/bash

echo "SHEll COnfig REstorer install script"
echo ""

CONFIG_DIR="config"
SCRIPTS_DIR="scripts"
INSTALL_DIR="$HOME/.mkd"


if [ ! -d $SCRIPTS_DIR ];
then
    echo "Missing scripts directory"
    exit 1
fi

if [ ! -d $CONFIG_DIR ];
then
    echo "Missing samples directory"
    exit 1
fi

if [[ ! -f $SCRIPTS_DIR/utils.sh || ! -r $SCRIPTS_DIR/utils.sh ]];
then
    echo "Unable to import 'utils'"
    exit 1
fi

. $SCRIPTS_DIR/utils.sh

if [[ ! -f $SCRIPTS_DIR/dirs.sh || ! -r $SCRIPTS_DIR/dirs.sh ]];
then
    echo "Unable to import 'dirs'"
    exit 1
fi

. $SCRIPTS_DIR/dirs.sh

if [[ ! -f $SCRIPTS_DIR/aliases.sh || ! -r $SCRIPTS_DIR/aliases.sh ]];
then
    echo "Unable to import 'aliases'"
    exit 1
fi

. $SCRIPTS_DIR/aliases.sh

if [[ ! -f $SCRIPTS_DIR/variables.sh || ! -r $SCRIPTS_DIR/variables.sh ]];
then
    echo "Unable to import 'variables'"
    exit 1
fi

. $SCRIPTS_DIR/variables.sh


# currently tools is bash-only compatible so check if proper shell used
check_shell

# create additional env file and source it at the end of .bashrc
add_settings $INSTALL_DIR

# create standard set of directories
create_dirs $CONFIG_DIR/dirs

# add common aliases
add_aliases $CONFIG_DIR/aliases $INSTALL_DIR

# set environment variables
set_variables $CONFIG_DIR/variables $INSTALL_DIR

# finished
echo ""
echo "All tasks finished"
echo "Reload terminal or source '$INSTALL_DIR/shecore.env' file"
