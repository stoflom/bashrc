# Makefile for bashrc utilities

SHELL := /bin/bash

# --- Configuration ---
# Directory for shell functions to be sourced on login.
# Fedora automatically sources all files in this directory.
BASHRC_D_DIR := $(HOME)/.bashrc.d

# Directory for standalone executable scripts.
# Ensure this directory is in your $PATH.
BIN_DIR := $(HOME)/.local/bin

# Files containing functions to be sourced.
LIB_FILES := all.sh whence.sh ffile.sh cp-safe.sh dus.sh

# Standalone executable scripts.
EXEC_SCRIPTS := compare_and_delete.sh gdb-to-gpx.sh ffile-copy.sh

# --- Targets ---

.DEFAULT_GOAL := install
.PHONY: install uninstall list all

# Default target: install everything.
all: install

install:
	@echo "Installing library files to $(BASHRC_D_DIR)..."
	@mkdir -p $(BASHRC_D_DIR)
	@# Install library files with read permissions (644). They will be sourced, not executed.
	install -m 644 $(LIB_FILES) $(BASHRC_D_DIR)
	
	@echo "Installing executable scripts to $(BIN_DIR)..."
	@mkdir -p $(BIN_DIR)
	@# Install executable scripts with execute permissions (755).
	install -m 755 $(EXEC_SCRIPTS) $(BIN_DIR)
	
	@echo "✅ Installation complete."
	@echo "-> Functions in 'all.sh' will be available in new terminal sessions."
	@echo "-> Executable scripts are now in $(BIN_DIR)."

uninstall:
	@echo "Uninstalling scripts..."
	-rm -f $(addprefix $(BASHRC_D_DIR)/, $(notdir $(LIB_FILES)))
	-rm -f $(addprefix $(BIN_DIR)/, $(notdir $(EXEC_SCRIPTS)))
	@echo "✅ Uninstallation complete."

list:
	@echo "Library files to be installed in $(BASHRC_D_DIR):"
	@echo "  $(LIB_FILES)"
	@echo "\nExecutable scripts to be installed in $(BIN_DIR):"
	@echo "  $(EXEC_SCRIPTS)"