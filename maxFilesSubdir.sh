#!/bin/bash

yellowColor='\033[1;33m'
redColor='\033[0;31m'
noColor='\033[0m'

filesVolume() {
    [[ $# -ne 1 ]] && echo "Usage: $0 DIRECTORY" && exit 1

    DIR="$1"

    [[ ! -d "$DIR" ]] && echo "Error: '$DIR' is not a valid directory." && exit 1

    subdirs=("$DIR"/*)
    max_files=0
    max_dir=""

    has_directories=false

    for subdir in "${subdirs[@]}"
    do
        if [[ -d "$subdir" ]] 
        then
            has_directories=true
            num_files=$(find "$subdir" -maxdepth 1 -type f | wc -l)
            [[ "$num_files" -gt "$max_files" ]] && max_files="$num_files" && max_dir="$subdir"
        fi
    done

    "$has_directories" \
    && echo "Directory: $max_dir" \
    && echo "Number of files: $max_files" \
    || { echo "There are no subdirectories here"; exit 1; }
}

scriptHelp() {
printf \
"${yellowColor}$0${noColor} script
Usage: $0 [OPTIONS] DIRECTORY
This script finds the subdirectory with the most files in a given directory.
 
Options:
    -h, --help     Display this help message and exit.
 
Arguments:
    DIRECTORY      Specified directory to find subdirectory\n"
    exit 0
}

[ "$1" == "-help" ] && scriptHelp || filesVolume "$@"
