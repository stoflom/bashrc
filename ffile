#!/usr/bin/env bash
# find file in current directory hierarchy
ffile()
{
    # Check if an argument was provided
    if [ -z "$1" ]; then
        echo "Error: Please provide a filename pattern." >&2
        echo "Usage: ffile <pattern>   (a wildcard will be added in front)" >&2
        echo "e.g. ffile IGP0967.* " >&2
        return 1
    fi

    # Execute the find command
    find -L . -name "*${1}"
}
