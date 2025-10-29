##!/bin/bash

# Function to copy a file with an incrementing number if a file with the same name exists
# this differs from cp --backup=numbered in that the file extension is preserved:
# filename.gpx -> filename#1.gpx etc.

cp-safe() {
  if [ "$#" -ne 2 ]; then
    echo "Usage: cp-safe <source_file> <destination>" >&2
    echo "  <destination> can be a directory or a file path." >&2
    return 1
  fi

  local source_file="$1"
  local dest="$2"
  local dest_dir
  local dest_filename

   # Determine if destination is a directory or a file path
  if [ -d "$dest" ]; then
    # Destination is a directory
    dest_dir="$dest"
    dest_filename=$(basename -- "$source_file")
  else
    # Destination is a file path
    dest_dir=$(dirname -- "$dest")
    dest_filename=$(basename -- "$dest")
  fi

  # Create destination directory if it doesn't exist
  if [ ! -d "$dest_dir" ]; then
    mkdir -p -- "$dest_dir" || { echo "Error: Failed to create directory '$dest_dir'." >&2; return 1; }
  fi

  local filename="$dest_filename"
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
}

# To use: source cp-safe.sh in your script or terminal session or add to your bashrc

# Example usage
# Copy a single file
# To use, source this file in your script or terminal session, or add it to your .bashrc:
#   source /path/to/cp-safe.sh
#
# Example Usage:
#   cp-safe source.txt /path/to/dest_dir/      # Copies to /path/to/dest_dir/source.txt
#   cp-safe source.txt /path/to/dest_dir/new.txt # Copies to /path/to/dest_dir/new.txt
#   # If new.txt exists, it will be copied as new#1.txt, new#2.txt, etc.

# Copy all .jpg files from a source directory, excluding subdirectories
##for file in /path/to/source_directory/*.jpg; do
##  if [ -f "$file" ]; then
##    cp_safe "$file" "/path/to/destination_directory"
##  fi
##done
