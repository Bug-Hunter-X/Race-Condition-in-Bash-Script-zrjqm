#!/bin/bash

# This script demonstrates a solution to the race condition problem.
# Use a lock file to prevent concurrent access
LOCKFILE="myfile.lock"

# Create a file
echo '' > myfile.txt

# Function to write to the file with locking
write_to_file() {
  local process_name=$1
  while true; do
    flock -n $LOCKFILE || { echo "$process_name: Waiting for lock..." >&2; sleep 1; continue; }
    echo "$process_name" >> myfile.txt
    flock -u $LOCKFILE
    sleep 1
  done
}

# Run two processes using the write_to_file function
write_to_file "Process 1" &
write_to_file "Process 2" &

# Let the processes run for a few seconds (Adjust as needed)
sleep 5

# Kill the background processes
kill %1 %2

# Print the file's content.
cat myfile.txt

# Clean up lock file
rm -f $LOCKFILE