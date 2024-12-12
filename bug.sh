#!/bin/bash

# This script demonstrates a race condition bug.

# Create a file
echo '' > myfile.txt

# Race condition: Two processes try to write to the same file concurrently.
# Process 1
( while true; do echo "Process 1" >> myfile.txt; sleep 1; done ) &
# Process 2
( while true; do echo "Process 2" >> myfile.txt; sleep 1; done ) &

# Let the processes run for a few seconds (Adjust as needed)
sleep 5

# Kill the background processes
kill %1 %2

# Print the corrupted file's content.
cat myfile.txt