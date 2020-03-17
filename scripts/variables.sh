#!/bin/bash

set_variables() {
    echo "* setting variables ..."
    # check in loop if alias exists and add/update
    if [ -z "$1" ];
    then
        mkd_error "No path to variables file given"
    fi
    if [ -z "$2" ];
    then
        mkd_error "No output dir given"
    fi

    vars_path=$2/variables.env
    echo > $vars_path << EOM
# This is auto generated file - do not modify it manualy
# If any modification needed please update variables.source
# and run ~/.mkd/scripts/update.sh or call 'mkd_tool_update'

EOM

    grep -v --line-buffered "^\$" $1 | grep -v --line-buffered "^#" | while read -r var ;
    do
        # TODO add checking for PATH variable update
        echo "** variable set: $var"
        echo "export $var" >> $vars_path
    done
    echo "... done"

    echo "* registering variables file in shecore setting"
    echo ". $vars_path" >> $2/shecore.env
    echo "... done"
}
