##!/bin/bash

# Function to copy a file with an incrementing number if a file with the same name exists
# this differs from cp --backup=numbered in that the file extension is preserved:
# filename.gpx -> filename#1.gpx etc.

cp_safe() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: cp_safe <source_file(s)> <destination_dir>" >&2
    echo "  Supports wildcards: cp_safe '*.txt' /dest/ or cp_safe * /dest/" >&2
    return 1
  fi

  # Last argument is always the destination
  local dest="${!#}"
  # All preceding arguments are source files (expand globs if needed)
  local files=()
  for ((i=1; i<$#; i++)); do
    local arg="${!i}"
    # If arg contains glob characters, expand it
    if [[ "$arg" == *[\*\?\[]* ]]; then
      for f in $arg; do
        [ -e "$f" ] && files+=("$f")
      done
    else
      files+=("$arg")
    fi
  done

  if [ "${#files[@]}" -eq 0 ]; then
    echo "Error: No source files provided." >&2
    return 1
  fi

  # Destination must be a directory when copying multiple files
  if [ "${#files[@]}" -gt 1 ] && [ ! -d "$dest" ]; then
    echo "Error: Destination '$dest' must be a directory when copying multiple files." >&2
    return 1
  fi

  local dest_dir
  local dest_filename

  # Determine if destination is a directory or a file path
  if [ -d "$dest" ]; then
    dest_dir="$dest"
  else
    dest_dir=$(dirname -- "$dest")
    dest_filename=$(basename -- "$dest")
  fi

  # Create destination directory if it doesn't exist
  if [ ! -d "$dest_dir" ]; then
    mkdir -p -- "$dest_dir" || { echo "Error: Failed to create directory '$dest_dir'." >&2; return 1; }
  fi

  for source_file in "${files[@]}"; do
    local filename
    if [ -d "$dest" ]; then
      filename=$(basename -- "$source_file")
    elif [ -n "$dest_filename" ]; then
      filename="$dest_filename"
    else
      filename=$(basename -- "$source_file")
    fi

    local name="${filename%.*}"
    local ext="${filename##*.}"

    if [ "$filename" == "$ext" ]; then
      ext=""
    else
      ext=".${ext}"
    fi

    local i=0
    local new_filename="${name}${ext}"

    # Find the next available number
    while [ -e "${dest_dir}/${new_filename}" ]; do
      i=$((i+1))
      new_filename="${name}#${i}${ext}"
    done

    # Copy the file with the new name (verbose)
    cp -v "$source_file" "${dest_dir}/${new_filename}"
  done
}

# To use: source cp_safe.sh in your script or terminal session or add to your bashrc

# Example usage
# Copy a single file
# To use, source this file in your script or terminal session, or add it to your .bashrc:
#   source /path/to/cp_safe.sh
#
# Example Usage:
#   cp_safe source.txt /path/to/dest_dir/      # Copies to /path/to/dest_dir/source.txt
#   cp_safe source.txt /path/to/dest_dir/new.txt # Copies to /path/to/dest_dir/new.txt
#   # If new.txt exists, it will be copied as new#1.txt, new#2.txt, etc.
#
# With wildcards (shell expands * before calling):
#   cp_safe * /path/to/dest_dir/               # Copies all files to dest_dir
#   cp_safe *.txt /path/to/dest_dir/           # Copies all .txt files to dest_dir
#   cp_safe '/path/to/*.jpg' /other/dest/      # Copies all .jpg files

# Copy all .jpg files from a source directory, excluding subdirectories
##for file in /path/to/source_directory/*.jpg; do
##  if [ -f "$file" ]; then
##    cp_safe "$file" "/path/to/destination_directory"
##  fi
##done
