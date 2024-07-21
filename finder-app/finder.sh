#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Error: Two arguments are required."
    echo "Usage: $0 <filesdir> <searchstr>"
    exit 1
fi

filesdir="$1"
searchstr="$2"

# Check if filesdir is a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: '$filesdir' is not a directory."
    exit 1
fi

# Function to count files recursively
count_files() {
    local dir="$1"
    local count=$(find "$dir" -type f | wc -l)
    echo "$count"
}

# Function to count matching lines
count_matching_lines() {
    local dir="$1"
    local search="$2"
    local count=0
    while IFS= read -r file; do
        local matches=$(grep -i "$search" "$file" | wc -l)
        (( count += matches ))
    done < <(find "$dir" -type f)
    echo "$count"
}

# Count files and matching lines
num_files=$(count_files "$filesdir")
num_matches=$(count_matching_lines "$filesdir" "$searchstr")

# Print results
echo "The number of files are $num_files and the number of matching lines are $num_matches"

