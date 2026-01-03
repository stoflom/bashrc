#!/usr/bin/env bash

# find file in given/current directory hierarchy
ffile()
{
    # 1. Check if the pattern argument ($1) was provided
    if [ -z "$1" ]; then
        echo "Error: Provide a filename pattern." >&2
        echo "Usage: ffile <pattern> [<dir>]" >&2
        echo "If <dir> is empty, the current directory is used." >&2
        echo "e.g. ffile \"IGP0967.*\" /" >&2
        echo "e.g. ffile \"*.log\"" >&2
        echo "e.g. ffile \"=IGP0967.txt\" (exact match)" >&2
        return 1
    fi

    # 2. Determine the search directory
    # If $2 is provided and non-empty, use it. Otherwise, use $PWD.
    # The ${VAR:-default} syntax is a common, clean way to set a default value.
    local search_dir="${2:-$PWD}"
    
    # 3. Validate the search directory exists
    if [ ! -d "$search_dir" ]; then
        echo "Error: Directory '$search_dir' does not exist." >&2
        return 1
    fi
    
    # 4. Define the search pattern
    # Support exact matches with = prefix or contains searches
    local pattern="${1}"
    if [[ "$pattern" == "="* ]]; then
        # Exact match - remove the = prefix
        pattern="${pattern#=}"
    elif [[ "$pattern" != *"*"* ]]; then
        # No wildcards - make it a contains search
        pattern="*${pattern}*"
    fi

    # 5. Execute the find command
    # -L follows symbolic links.
    # -name uses the wildcard pattern.
    echo "Searching for '$pattern' starting in '$search_dir'..." >&2
    find -L "${search_dir}" -name "${pattern}"

    return 0 # Explicitly indicate success
}

