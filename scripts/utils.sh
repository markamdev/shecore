#!/bin/bash

HELP=0
PROFILES=()

_add_profile() {
    echo "Creating files for new profile $1"
    echo "NOT YET IMPLEMENTED!"
    exit 1
}


_check_profile() {
    if [ ! -d ./profiles/$1 ];
    then
        echo "Profile '$1' does not exist - exiting"
        exit 1
    fi
}

_list_profiles() {
    echo "List of profiles:"
    echo "NOT YET IMPLEMENTED!"
    exit 1
}

parse_option() {
    if [ $# == 0 ];
    then
        HELP=1
        return
    fi
    while [ $# -gt 0 ]
    do
        current=$1
        case $current in
            help)
            HELP=1
            break
            ;;
            new)
            _add_profile $2
            break
            ;;
            list)
            _list_profiles
            ;;
            *)
            PROFILES+=("$current")
            shift
            ;;
        esac

    done
}

print_help() {
    echo "Usage:"
    echo "* $(basename $1) help                         print help message (current screen)"
    echo "* $(basename $1) new <name>                   create new empty profile <name>"
    echo "* $(basename $1) list                         print list of available profiles"
    echo "* $(basename $1) <profileA> ... <profileZ>    apply settings from given profiles"
    echo "- - - -"
    exit 0
}

_process_profile() {
    # save PROFILE_DIR and CACHE_DIR
    PR_DIR=$1
    C_DIR=$2
    for part in bash dirs apps
    do
        echo "... processing $part"
        if [ -e ./profiles/$PR_DIR/$part ];
        then
            cat ./profiles/$PR_DIR/$part | grep -v "^#" | grep -v "^$" >> $C_DIR/$part
        fi
    done
    # remove duplicates from directories list
    cat $C_DIR/dirs | sort -u > $C_DIR/sorted_dirs
}

_apply_apps() {
    return 1
}

_apply_dirs() {
    echo "creating set of directories (if not existing yet)"
    for dr in $(cat $1)
    do
        echo "... $dr"
        mkdir -p $dr
    done
}

_apply_shecore() {
    SRC=$1
    # check if ~/.bashrc file exist (create if not)
    if [ ! -e ~/.bashrc ];
    then
        touch ~/.bashrc
    fi
    DEST=~/.shecore
    # check if ~/.shecore dir exists (create if not)
    if [ ! -e $DEST ];
    then
        mkdir $DEST
    fi

    # copy bash settings to ~/.shecore
    echo "copying bash settings"
    cp $SRC/bash $DEST/bash

    # check if SHECORE_MARK and sourcing exists in ~/.bashrc (add if not)
    echo "checking if SHECORE_MARK added to .bashrc"
    mark=$(cat ~/.bashrc | grep SHECORE_MARK | wc -l)
    if [ $mark -eq 0 ];
    then
        echo "... no SHECORE_MARK found"
        cat <<EOM >> ~/.bashrc
# SHECORE_MARK <- added automatically by SheCoRe tool from https://github.com/markamdev/shecore
source ~/.shecore/bash
# ---
EOM
    else
        echo "... SHECORE_MARK already exist"
    fi

    # apply dirs
    _apply_dirs $SRC/dirs

    # apply apps (TODO)
    return 1
}
