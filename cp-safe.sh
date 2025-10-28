##!/bin/bash

# Function to copy a file with an incrementing number if a file with the same name exists
cp-safe() {
  local source_file="$1"
  local dest_dir="$2"
  local filename=$(basename -- "$source_file")
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
    new_filename="${name}(${i})${ext}"
  done
  
  # Copy the file with the new name
  cp -v "$source_file" "${dest_dir}/${new_filename}"
}

# To use: source cp-safe.sh in your script or terminal session or add to your bashrc

# Example usage
# Copy a single file
##cp-safe source_file.txt /path/to/destination_directory

# Copy all .jpg files from a source directory, excluding subdirectories
##for file in /path/to/source_directory/*.jpg; do
##  if [ -f "$file" ]; then
##    cp_safe "$file" "/path/to/destination_directory"
##  fi
##done

