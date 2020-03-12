#!/bin/bash

mkd_error() {
    if [ "$1" == "" ];
    then
        echo "Error occured - exiting"
    else
        echo "Error: $1"
        echo "Exiting from script"
    fi
    exit 1
}

check_shell() {
    echo "* checking current shell ..."
    if [ `echo $SHELL | grep bash | wc -l` -ne 1 ];
    then
        mkd_error "Non-bash shell detected"
    fi
    echo "... Bash detected"
    echo "* checking .bashrc file ..."
    if [ ! -e $HOME/.bashrc ];
    then
        mkd_error ".bashrc not found - are you using Bash?"
    fi
    echo "... proper shell settings file found"
}

add_settings() {
    echo "* preparing tool directory ($1) ..."
    if [ ! -d $1 ];
    then
        mkdir -p $1
        if [ $? -ne 0 ];
        then
            # command failed
            mkd_error "Failed to create output directory"
        else
            echo "... prepared "
        fi
    fi

    SHCR=$1/shecore.env

    echo "* checking if SHeCoRe settings file already exists"
    if [ -f $SHCR ];
    then
        echo "... file found"
    else
        echo "** preparing empty SHeCoRe settings file ..."
        touch $SHCR
        if [ $? -ne 0 ];
        then
            mkd_error "Failed to prepare new file"
        fi
        echo "... done"
    fi

    echo "* checking if SHeCoRe settings already used in .bashrc ..."
    if [ `grep "$SHCR" $HOME/.bashrc | wc -l` -eq 0 ];
    then
        echo "** adding SHeCoRe settings to .bashrc ..."
        cat << EOT >> $HOME/.bashrc

# Settings for SHeCoRe
. $SHCR
EOT
        echo "... done"

        echo "** adding test command (mkd_shecore) ..."
        INSTALL_DATE=`date +"%Y.%m.%d"`
        echo "alias mkd_shecore='echo SHeCoRe installed on: $INSTALL_DATE'" >> $SHCR
        echo "... done"
    else
        echo "... SHeCoRe settings already in use"
    fi

}