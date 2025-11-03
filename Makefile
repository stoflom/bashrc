# Makefile for bashrc utilities

SHELL := /bin/bash

# --- Configuration ---
# Directory for shell functions to be sourced on login.
# Fedora automatically sources all files in this directory.
BASHRC_D_DIR := $(HOME)/.bashrc.d

# Files containing functions to be sourced.
LIB_FILES := all.sh whence.sh ffile.sh cp-safe.sh dus.sh

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
	
	
	@echo "✅ Installation complete."
	@echo "-> Functions in 'all.sh' will be available in new terminal sessions."

uninstall:
	@echo "Uninstalling scripts..."
	-rm -f $(addprefix $(BASHRC_D_DIR)/, $(notdir $(LIB_FILES)))
	@echo "✅ Uninstallation complete."

list:
	@echo "Library files to be installed in $(BASHRC_D_DIR):"
	@echo "  $(LIB_FILES)"

