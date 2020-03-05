#!/bin/bash

create_dirs() {
    echo "* creating base directories ..."
    if [ -z $1 ];
    then
        mkd_error "No path to 'dirs' file given"
    fi
    if [[ ! -f $1 || ! -r $1 ]];
    then
        mkd_error "Invalid path to 'dirs' given"
    fi

    LINES=`grep -v "^\$" $1 | grep -v "^#"`
    echo $LINES
    for dr in $LINES
    do
        echo "** processing $dr ..."
        if [ -e $HOME/$dr ];
        then
            echo "... already exists"
        else
            mkdir -p $HOME/$dr
            if [ $? -ne 0 ];
            then
                mkd_error "Failed to create $dr"
            else
                echo "... created"
            fi
        fi
    done
}