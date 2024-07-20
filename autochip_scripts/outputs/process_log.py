import re
import sys

def process_log_file(input_file, output_file, additional_file):
    # Read the log file
    with open(input_file, 'r') as file:
        lines = file.readlines()

    # Read the additional file content
    with open(additional_file, 'r') as file:
        additional_content = file.read()

    # Initialize variables to track relevant information
    best_ranked_response = "0"
    response_number = "0"
    rank_of_best_response = "0"

    # Find the last "user:" line and determine if it contains a compilation error or warning
    for line in reversed(lines):
        if line.startswith("user:"):
            if "The design failed to compile." in line:
                rank_of_best_response = "-1"
            elif "The design compiled with warnings." in line:
                rank_of_best_response = "-0.5"
            break

    # Create the new output with necessary changes
    new_lines = []
    for line in lines:
        if "Best ranked response at iteration" in line:
            line = re.sub(r'Best ranked response at iteration -1', f'Best ranked response at iteration {best_ranked_response}', line)
        if "with response number" in line:
            line = re.sub(r'with response number -1', f'with response number {response_number}', line)
        if "Rank of best response:" in line:
            line = re.sub(r'Rank of best response: 0', f'Rank of best response: {rank_of_best_response}', line)
        if "Best response module:" in line:
            line = line.strip() + "\n" + additional_content + "\n"
        new_lines.append(line)

    # Write the processed lines to the output file
    with open(output_file, 'w') as file:
        file.writelines(new_lines)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python script.py <input_file> <output_file> <additional_file>")
        sys.exit(1)

    input_file = sys.argv[1]
    output_file = sys.argv[2]
    additional_file = sys.argv[3]

    process_log_file(input_file, output_file, additional_file)

