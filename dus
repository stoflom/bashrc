# Calculate disk usage for all files in the current directory (including hidden files)
dus ()
{
    local dir="${1:-.}" # Use argument 1, or the current directory if no argument is given
    local dotglob_cmd=$(shopt -p dotglob) # save command to reset dotglob
    
    # Enable dotglob: this makes * also match files starting with a dot (hidden files).
    shopt -s dotglob
    
    # Check if we are running in the current directory or a specific one
    if [ "$dir" = "." ]; then
        echo "Calculating disk usage for all files in current directory"
        
        du -hs *
    else
        echo "Calculating disk usage for all files in directory: $dir"
        du -hs "$dir"/*
    fi

    # Restore dotglob to its original state
    $dotglob_cmd
}
