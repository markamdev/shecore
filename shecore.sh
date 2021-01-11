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

echo "- - - - -"
echo "All operations finished - please reload your console/terminal"
echo "- - - - -"
