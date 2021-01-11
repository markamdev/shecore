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
