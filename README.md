
# Bash Utilities

A collection of miscellaneous shell scripts for file management, system tasks, and command-line automation.

---

## Installation

This project uses a `Makefile` for easy installation and uninstallation of the scripts.

### Prerequisites

-   `make` must be installed.
-   This setup is optimized for Fedora-like systems where files in `~/.bashrc.d` are automatically sourced upon login.
-   The `~/.local/bin` directory should be in your `$PATH`. This is standard on most modern Linux distributions.

### Instructions

1.  **Install:** To install the scripts, run the following command from the project directory:
    ```bash
    make install
    ```
    This will:
    -   Copy library files (e.g., `all.sh`, `whence`, `ffile`) to `~/.bashrc.d/`. These provide functions for your interactive shell.
    -   Copy executable scripts (e.g., `compare_and_delete.sh`, `gdb-to-gpx.sh`) to `~/.local/bin/`, making them available as commands.

2.  **Uninstall:** To remove all installed scripts, run:
    ```bash
    make uninstall
    ```

---

#### Shell Functions (sourced on login)

These functions become available in your terminal after installation.

-   `all.sh`: The main file that sources all other function files.
-   `cp-safe`: A safe copy utility that renames the destination file with a numeric suffix (`#1`, `#2`, etc.) if it already exists, preserving the file extension.
-   `ffile`: A simple function to find files by name in the current directory hierarchy.
-   `whence`: An enhanced version of `type` that also shows `ls -al` output for the found executable.
-   Other functions available from `all.sh`: `dus`, `logout`, `cls`, `ff`.

### Executable Scripts (run as commands)

-   `ffile-copy.sh`: A powerful wrapper for `find` and `cp` to collect files into a single directory, handling name collisions.
-   `compare_and_delete.sh`: Finds and deletes files in a target directory that are content-duplicates of files in a reference directory.
-   `cp-safe.sh`: A safe copy utility that renames the destination file with a numeric suffix if it already exists.


