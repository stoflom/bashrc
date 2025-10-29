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
        # Use a temporary variable to trace the links.
        local target_path="$cmd_path"

        # 4. Loop as long as the current path is a symbolic link.
        # The '-h' or '-L' test checks if a path exists and is a symbolic link.
        while [[ -h "$target_path" ]] && [[ -e "$target_path" ]]; do
            echo "-> is a link:"
            ls -ld --color=auto "$target_path"

            # Get the link's target. It might be a relative path.
            local link_target
            link_target=$(readlink "$target_path")

            # If readlink fails (e.g., on a malformed link), target_path could be empty.
            # Break the loop to prevent errors.
            if [[ -z "$link_target" ]]; then
                echo "-> Error: Broken or unreadable symbolic link."
                break
            fi

            # Resolve the target path. If it's not absolute, resolve it relative to the link's directory.
            [[ "$link_target" == /* ]] && target_path="$link_target" || target_path="$(dirname -- "$target_path")/$link_target"
        done

        # 5. If the original command was a link, show the final target.
        # We know it was a link if the final path is different from the starting path.
        if [[ "$target_path" != "$cmd_path" ]]; then
            echo "-> final target:"
            # Use 'ls -ld' to correctly display info for files OR directories.
            ls -ld --color=auto "$target_path" || echo "-> Target not found (broken link chain)."
        fi
    fi
}
