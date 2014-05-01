#! /bin/bash

# print the directory that have the scripts (beyond symlinks)
# usage: mydir=$(find_my_dir_beyond_symlink)
#http://stackoverflow.com/a/246128/1527494
function find_my_dir_beyond_symlink
{
    local SOURCE="${BASH_SOURCE[0]}"
    local DIR
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    echo $DIR
}

mydir=$(find_my_dir_beyond_symlink)

source ${mydir}/lib-common-util

usage="$0 <target inst> <arch|arm;x86_64;i686> <make jobs|8>"

function my_goldfish_build_procedure
{
    hack_mod_build.sh ${target_inst} ${make_jobs}
}
export -f my_goldfish_build_procedure

source ${mydir}/lib-goldfish-build
