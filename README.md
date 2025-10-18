
A few useful bash functions to add to your bashrc file.

```
dus
```
calculates the disk space used by directories and files in the current directory, including hidden nodes.

```
dus <path>
```
 does the same for the specified `<path>`.


```
whence <cmd>
```
shows the type, location, and/or symbolic links defining `<cmd>`.


```
ffind <name>
```
searches for a given filename fragment `*<name>` in the current directory hierarchy. Note added initial wildcard. You can add more `*`s. Symbolic links are followed.


```
logout
```
(GNOME specific) logs the current user out and closes the GNOME session.


All these (and some other shortcuts) are defined in the file `all`. I drop this in my `~/.bashrc.d` folder to be loaded when I log in to Fedora/Rocky/CentOS/RedHat etc.
