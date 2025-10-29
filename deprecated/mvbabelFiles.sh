#find gpx files created by gpsbabel and move them to another directory

#using xargs
find /path/to/source/directory -maxdepth 0 -type f -print0 | xargs -0 grep -l "babel" | xargs -I {} mv {} /path/to/destination/directory

#or using find with -exec
find /path/to/source/directory -maxdepth 0 -type f -exec grep -q "babel" {} \; -exec mv {} /path/to/destination/directory \;
