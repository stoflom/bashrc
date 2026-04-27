# Get the directory of the currently executing script to source other files reliably.
if [[ -n "$BASH_SOURCE" ]]; then #
	_ALL_SH_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
	source "${_ALL_SH_SCRIPT_DIR}/whence.sh"
	source "${_ALL_SH_SCRIPT_DIR}/ffile.sh"
	source "${_ALL_SH_SCRIPT_DIR}/cp-safe.sh"
	source "${_ALL_SH_SCRIPT_DIR}/dus.sh"
fi

# Define logout for  gnome shell
logout() {
	DISPLAY=:0 gnome-session-quit --force
}

# Fix less for utf8 and color
export LESSCHARSET=utf-8
alias less='less -R'

# Alias clear
cls() {
	clear
}

# fix fastfetch
ff() {
	fastfetch -l none
}

#Shortcuts for some Gnome apps
gte() {
	/usr/bin/gnome-text-editor "$@" &>/dev/null &
}

gsm() {
	/usr/bin/gnome-system-monitor &>/dev/null &
}

# Favorite editpr
if [ -x /usr/bin/fresh ]; then
	export EDITOR=/usr/bin/fresh
fi

# shortcuts for disks to use: e.g. cd "$T7"      (note quotes "")
export MECER="/run/media/stoflom/MecerExternal"
export T7="/run/media/stoflom/T7Shield"

#Fix some sillyness
alias reboot='sudo systemctl reboot -i'
alias shutdown='sudo systemctl poweroff -i'
