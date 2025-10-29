# Define whence
whence ()
{ 
    if [[ -z "$1" ]]; then
        echo "Usage: whence <command>" >&2
        return 1
    fi

    # 1. Show the general type information (alias, function, builtin, file)
    type -a "$1"

    # 2. Find the path to the executable file, ignoring aliases and functions
    local cmd_path
    cmd_path=$(type -P "$1")

    # 3. If a path was found, analyze it for symbolic links
    if [[ -n "$cmd_path" ]]; then
        local current_path="$cmd_path"

        # 4. Loop through the link chain until we find a non-link file
        while [[ -L "$current_path" ]]; do
            echo "-> is a link:"
            ls -ld --color=auto "$current_path"
            current_path=$(readlink -f "$current_path")
        fi

        # 5. Show the final target file if it was different from the starting command path
        if [[ "$current_path" != "$cmd_path" ]]; then
            echo "-> final target:"
            ls -l --color=auto "$current_path"
        fi
    else
        echo "-> Not found as an executable file in \$PATH."
    fi
}
