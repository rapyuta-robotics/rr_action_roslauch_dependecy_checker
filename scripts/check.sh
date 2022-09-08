#!/bin/bash
source log.sh

if [ ! -d "$2" ]
then
    fatal "Path to analyze \"$2\" does not exist"
    print_usage
    exit 1
fi
ex=0
source $1 || ex=$?
if [ $ex -ne 0 ]
then
    fatal "Setup file sourcing ended abnormally"
    exit 2
fi
base_command="find $2 -name \"*.launch\""
if [ ! -z "$3" ]
then
    lines=($3)
    info "Some paths will be excluded from the analysis"
    base_command="$base_command | grep "
    for line in "${lines[@]}"
    do
        base_command="$base_command -v -e \"$line\""  
    done
fi
eval $base_command | xargs -I % -P 1 rosrun roslaunch roslaunch-check %
info "Dependency check finished"