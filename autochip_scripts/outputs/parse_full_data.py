import os
import re
import pandas as pd

# Define the root directory where the data is stored
root_dir = './full_results/claude-3-haiku-20240307'

# Regular expression patterns to extract the required information
time_pattern = re.compile(r"Time to Generate: ([\d\.eE+-]+)")
best_iteration_pattern = re.compile(r"Best ranked response at iteration (\d+) with response number (\d+)")
rank_pattern = re.compile(r"Rank of best response: ([\d\.eE+-]+)")

# Initialize a dictionary to store the extracted data
data = {}
prompts = set()

# Walk through the directory structure
for candidate_depth_dir in os.listdir(root_dir):
    candidate_depth_path = os.path.join(root_dir, candidate_depth_dir)
    if os.path.isdir(candidate_depth_path):
        candidate_depth_parts = candidate_depth_dir.split('_')
        if len(candidate_depth_parts) == 2 and candidate_depth_parts[0].startswith('can') and candidate_depth_parts[1].startswith('depth'):
            candidate = candidate_depth_parts[0]
            depth = int(candidate_depth_parts[1][5:])  # Extract numerical depth value

            human_dir_path = os.path.join(candidate_depth_path, 'machine')

            print(f"Parsing data for Candidate: {candidate}, Depth: {depth}")  # Debug print
            print(human_dir_path)
            for prompt_dir in os.listdir(human_dir_path):
                prompts.add(prompt_dir)  # Collect prompt names
                prompt_path = os.path.join(human_dir_path, prompt_dir)
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
                                    if candidate not in data:
                                        data[candidate] = {}
                                    if depth not in data[candidate]:
                                        data[candidate][depth] = {}
                                    data[candidate][depth][prompt_dir] = {
                                        'Best Iteration': best_iteration,
                                        'Best Response': best_response_number,
                                        'Rank of Best Response': rank_of_best_response,
                                        'Time to Generate': time_to_generate
                                    }
                                    break  # Stop processing this file once the required data is found

# Convert the data dictionary to a pandas DataFrame
columns = []
for candidate in sorted(data.keys()):
    for depth in sorted(data[candidate].keys()):
        columns.append((candidate, f'depth{depth}', 'Best Iteration'))
        columns.append((candidate, f'depth{depth}', 'Best Response'))
        columns.append((candidate, f'depth{depth}', 'Rank of Best Response'))
        columns.append((candidate, f'depth{depth}', 'Time to Generate'))

# Create a multi-index for the columns
multi_index = pd.MultiIndex.from_tuples(columns, names=['Candidate', 'Depth', 'Metric'])

# Create a DataFrame with the multi-index columns
df_data = []
for prompt in sorted(prompts):
    row = []
    for candidate in sorted(data.keys()):
        for depth in sorted(data[candidate].keys()):
            if prompt in data[candidate][depth]:
                row.append(data[candidate][depth][prompt]['Best Iteration'])
                row.append(data[candidate][depth][prompt]['Best Response'])
                row.append(data[candidate][depth][prompt]['Rank of Best Response'])
                row.append(data[candidate][depth][prompt]['Time to Generate'])
            else:
                row.extend([None, None, None, None])
    df_data.append(row)

df = pd.DataFrame(df_data, index=sorted(prompts), columns=multi_index)

# Calculate the total number of "1"s in the "Rank of Best Response" columns
total_ones_data = []
percent_ones_data = []
average_data = []
for candidate in sorted(data.keys()):
    for depth in sorted(data[candidate].keys()):
        for metric in ['Best Iteration', 'Best Response', 'Rank of Best Response', 'Time to Generate']:
            if metric == 'Rank of Best Response':
                rank_col = (candidate, f'depth{depth}', metric)
                if rank_col in df.columns:
                    total_ones = df[rank_col].eq(1).sum()
                    percent_ones = total_ones / len(df[rank_col])
                    print(len(df[rank_col]))
                    non_negative_values = df[rank_col][df[rank_col] >= 0]
                    average_value = non_negative_values.mean() if not non_negative_values.empty else None
                else:
                    total_ones = 0
                    percent_ones = 0
                    average_value = None
                total_ones_data.append(total_ones)
                percent_ones_data.append(percent_ones)
                average_data.append(average_value)
            else:
                total_ones_data.append(None)
                percent_ones_data.append(None)
                average_data.append(None)

# Add the summary statistics to the DataFrame
summary_df = pd.DataFrame([total_ones_data, percent_ones_data, average_data], columns=multi_index, index=['Total number of 1s', 'Percent Ones', 'Average Rank'])
df = pd.concat([df, summary_df])

# Save the DataFrame to an Excel file
output_excel = './data_sheets/haiku_data_MACHINE.xlsx'
df.to_excel(output_excel)

print(f"Data has been parsed and saved to {output_excel}")

