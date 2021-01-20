#!/bin/bash

echo "- - - - -"
echo "SHEll COnfig REstorer"
echo "- - - - -"

. ./scripts/utils.sh

# print help if requested
parse_option $@

if [ $HELP -eq 1 ];
then
    print_help $0
fi

# check if any profile selected
if [ ${#PROFILES[@]} -gt 0 ];
then
    echo "List of profiles selected to be applied: ${PROFILES[@]}"

    # check if all defined profiles exist
    for prf in ${PROFILES[@]}
    do
        echo "checking $prf ..."
        _check_profile $prf
    done
fi

# do not work on target files - use temporary cache
CACHEDIR=.cache

if [ -d $CACHEDIR ];
then
# be sure to work on clear files
    rm -r $CACHEDIR/*
fi

# prepare cache directory if does not exists
mkdir -p $CACHEDIR

# process each profile one by one and prepare data in cache
for prf in ${PROFILES[@]}
do
    echo "processing $prf ..."
    _process_profile $prf $CACHEDIR
done

# prepare ~/.shecore directory (if not exist), attach bash settings, create dirs and so
_apply_shecore $CACHEDIR

echo "- - - - -"
echo "All operations finished - please reload your console/terminal"
echo "- - - - -"
