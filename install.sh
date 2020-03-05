#!/bin/bash

echo "SHEll COnfig REstorer install script"
echo ""

CONFIG_DIR="config"
SCRIPTS_DIR="scripts"
INSTALL_DIR="$HOME/.mkd/"


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

# currently tools is bash-only compatible so check if proper shell used
check_shell

# create additional env file and source it at the end of .bashrc
add_settings $INSTALL_DIR

# create standard set of directories
create_dirs $CONFIG_DIR/dirs
