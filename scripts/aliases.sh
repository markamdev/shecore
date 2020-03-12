#!/bin/bash

add_aliases() {
    echo "* adding aliases ..."
    # check in loop if alias exists and add/update
    if [ -z "$1" ];
    then
        mkd_error "No path to alias file given"
    fi
    if [ -z "$2" ];
    then
        mkd_error "No output dir given"
    fi

    alias_path=$2/aliases.env
    echo > $alias_path << EOM
# This is auto generated file - do not modify it manualy
# If any modification needed please update aliases.source
# and run ~/.mkd/update.sh or call 'mkd_tool_update'

# Default MKD aliases
alias mkd_tool_update='~/.mkd/update.sh'
alias mkd_tool_sync='echo "Syncing not yet supported"'

# User defined aliases
EOM


    grep -v --line-buffered "^\$" $1 | grep -v --line-buffered "^#" | while read -r al ;
    do
        echo "** adding alias: mkd_$al"
        echo "alias mkd_$al" >> $alias_path
    done
    echo "... done"

    echo "* registering aliases file in shecore setting"
    echo ". $alias_path" >> $2/shecore.env
    echo "... done"

    # copy alias config file for future updates and syncing
    cp $1 $2/aliases.source
}