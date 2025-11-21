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
        return 1
    fi

    # 2. Determine the search directory
    # If $2 is provided and non-empty, use it. Otherwise, use $PWD.
    # The ${VAR:-default} syntax is a common, clean way to set a default value.
    local search_dir="${2:-$PWD}"
    
    # 3. Define the search pattern
    # We'll use the user's input, but ensure it starts with a wildcard
    # for a "contains" search, if it doesn't already.
    local pattern="${1}"
    if [[ "$pattern" != "*"* ]]; then
        pattern="*${pattern}"
    fi

    # 4. Execute the find command
    # -L follows symbolic links.
    # -name uses the wildcard pattern.
    echo "Searching for '$pattern' starting in '$search_dir'..." >&2
    find -L "${search_dir}" -name "${pattern}"

    return 0 # Explicitly indicate success
}
