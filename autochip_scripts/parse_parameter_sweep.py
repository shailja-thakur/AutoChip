import os
import csv
import re

# Define the root directory where the data is stored
root_dir = './outputs/parameter_sweep/'

# Regular expression patterns to extract the required information
time_pattern = re.compile(r"Time to Generate: ([\d\.]+)")
best_iteration_pattern = re.compile(r"Best ranked response at iteration (\d+) with response number (\d+)")
rank_pattern = re.compile(r"Rank of best repsonse: ([\d\.]+)")

# Initialize a list to store the extracted data
data = []

# Walk through the directory structure
for candidate_depth_dir in os.listdir(root_dir):
    candidate_depth_path = os.path.join(root_dir, candidate_depth_dir)
    if os.path.isdir(candidate_depth_path):
        candidate_depth_parts = candidate_depth_dir.split('_')
        if len(candidate_depth_parts) == 2 and candidate_depth_parts[0].startswith('candidate') and candidate_depth_parts[1].startswith('depth'):
            candidate = candidate_depth_parts[0]
            depth = candidate_depth_parts[1]
            for prompt_dir in os.listdir(candidate_depth_path):
                prompt_path = os.path.join(candidate_depth_path, prompt_dir)
                log_file = os.path.join(prompt_path, 'log.txt')

                if os.path.exists(log_file):
                    with open(log_file, 'r') as f:
                        lines = f.readlines()

                        # Initialize variables to store the extracted values
                        time_to_generate = None
                        best_iteration = None
                        best_response_number = None
                        rank_of_best_response = None

                        for line in lines:
                            time_match = time_pattern.search(line)
                            if time_match:
                                time_to_generate = float(time_match.group(1))

                            best_iteration_match = best_iteration_pattern.search(line)
                            if best_iteration_match:
                                best_iteration = int(best_iteration_match.group(1))
                                best_response_number = int(best_iteration_match.group(2))

                            rank_match = rank_pattern.search(line)
                            if rank_match:
                                rank_of_best_response = float(rank_match.group(1))
                                # Append the data when all required values are found
                                if time_to_generate is not None and best_iteration is not None and best_response_number is not None and rank_of_best_response is not None:
                                    data.append([
                                        candidate,
                                        depth,
                                        prompt_dir,
                                        best_iteration,
                                        best_response_number,
                                        rank_of_best_response
                                    ])
                                    break  # Stop processing this file once the required data is found

# Write the extracted data to a CSV file
output_csv = 'outputs/parsed_data.csv'
with open(output_csv, 'w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile)
    csvwriter.writerow(['Candidate', 'Depth', 'Prompt', 'Best Iteration', 'Best Response Number', 'Rank of Best Response'])
    csvwriter.writerows(data)

print(f"Data has been parsed and saved to {output_csv}")
