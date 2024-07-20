#!/bin/bash

# Usage: ./process_logs.sh <base_directory>
# Example: ./process_logs.sh /path/to/base_dir

# Check if the correct number of arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <base_directory>"
    exit 1
fi

# Set the base directory
BASE_DIR=$1

# Check if the base directory exists
if [ ! -d "$BASE_DIR" ]; then
    echo "Error: Base directory $BASE_DIR does not exist."
    exit 1
fi

# Iterate through directories directly under the base directory
for PARENT_DIR in "$BASE_DIR"/*/; do
    # Check if log.txt exists in the parent directory
    LOG_FILE="$PARENT_DIR/log.txt"
    if [ -f "$LOG_FILE" ]; then
        # Check if the log file contains the specific error
        if grep -q "Best ranked response at iteration -1" "$LOG_FILE"; then
            # Define the additional file path
            ADDITIONAL_FILE="$PARENT_DIR/iter0/response0/top_module.sv"

            # Check if the additional file exists
            if [ ! -f "$ADDITIONAL_FILE" ]; then
                echo "Error: Additional file $ADDITIONAL_FILE does not exist in $PARENT_DIR/iter0."
                continue
            fi

            # Define the output file path
            OUTPUT_FILE="${LOG_FILE%.log.txt}_processed.log.txt"

            # Run the Python script on each log file
            python3 process_log.py "$LOG_FILE" "$OUTPUT_FILE" "$ADDITIONAL_FILE"

            if [ $? -eq 0 ]; then
                echo "Processed $LOG_FILE successfully."
            else
                echo "Failed to process $LOG_FILE."
            fi
        else
            echo "No error found in $LOG_FILE. Skipping."
        fi
    fi
done

echo "Processing completed."

