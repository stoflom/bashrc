
# Load Angular CLI autocompletion.
#:source <(ng completion script)

# Get the directory of the currently executing script to source other files reliably.
if [[ -n "$BASH_SOURCE" ]]; then
    _ALL_SH_SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    source "${_ALL_SH_SCRIPT_DIR}/whence.sh"
    source "${_ALL_SH_SCRIPT_DIR}/ffile.sh"
    source "${_ALL_SH_SCRIPT_DIR}/cp-safe.sh"
    source "${_ALL_SH_SCRIPT_DIR}/dus.sh"
fi

# Define logout for  gnome shell
logout ()
{
 	DISPLAY=:0 gnome-session-quit --force
}

# Fix less for utf8
export LESSCHARSET=utf-8

# Alias clear
cls ()
{
    clear;
}

# fix fastfetch
ff ()
{
    fastfetch -l none;
}
