import os
import re
import pandas as pd
import matplotlib.pyplot as plt
from adjustText import adjust_text

def identify_pareto(points):
    points = sorted(points, key=lambda x: (x[0], -x[1]))  # Sort by effort, then by accuracy (descending)
    pareto_points = []
    current_best = None
    for point in points:
        if current_best is None or point[1] > current_best[1]:
            pareto_points.append(point)
            current_best = point
    return pareto_points

# Define the list of root directories where the data is stored
root_dirs = ['../full_results/gpt-4o', '../full_results/gpt-3p5-turbo', '../full_results/claude-3-haiku']  # Add all your directories here
#root_dirs = ['../full_results/gpt-4o_depth0']  # Add all your directories here
models = ['GPT-4o', 'GPT-3.5T', 'Haiku']  # Corresponding names for the models
#models = ['GPT-4o']  # Corresponding names for the models

# CSV file path for additional models
csv_file_path = './data_machine.csv'  # Path to the CSV file

# Regular expression patterns to extract the required information
time_pattern = re.compile(r"Time to Generate: ([\d\.eE+-]+)")
best_iteration_pattern = re.compile(r"Best ranked response at iteration (\d+) with response number (\d+)")
rank_pattern = re.compile(r"Rank of best response: ([\d\.eE+-]+)")

# Initialize a dictionary to store the extracted data
all_data = []
prompts = set()

# Function to process a single directory
def process_directory(root_dir, model_name):
    data = {}
    for candidate_depth_dir in os.listdir(root_dir):
        candidate_depth_path = os.path.join(root_dir, candidate_depth_dir)
        if os.path.isdir(candidate_depth_path):
            candidate_depth_parts = candidate_depth_dir.split('_')
            if len(candidate_depth_parts) == 2 and candidate_depth_parts[0].startswith('can') and candidate_depth_parts[1].startswith('depth'):
                candidate = candidate_depth_parts[0]
                depth = int(candidate_depth_parts[1][5:])  # Extract numerical depth value

                human_dir_path = os.path.join(candidate_depth_path, 'machine')

                print(f"Parsing data for Model: {model_name}, Candidate: {candidate}, Depth: {depth}")  # Debug print
                for prompt_dir in os.listdir(human_dir_path):
                    prompts.add(prompt_dir)  # Collect prompt names
                    prompt_path = os.path.join(human_dir_path, prompt_dir)
                    log_file = os.path.join(prompt_path, 'log.txt')

                    total_calls = 0
                    best_response_found = False
                    best_response_number = None
                    best_iteration = None
                    rank_of_best_response = None

                    # Count the total number of response directories
                    for iter_dir in os.listdir(prompt_path):
                        iter_path = os.path.join(prompt_path, iter_dir)
                        if os.path.isdir(iter_path):
                            response_count = len([name for name in os.listdir(iter_path) if os.path.isdir(os.path.join(iter_path, name))])
                            total_calls += response_count

                    if os.path.exists(log_file):
                        with open(log_file, 'r') as f:
                            lines = f.readlines()

                            # Initialize variables to store the extracted values
                            time_to_generate = None

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

                                    if rank_of_best_response == 1.0:
                                        best_response_found = True
                                        total_calls -= (response_count - (best_response_number + 1))
                                        break  # Stop processing this file once the required data is found

                            if candidate not in data:
                                data[candidate] = {}
                            if depth not in data[candidate]:
                                data[candidate][depth] = {}
                            data[candidate][depth][prompt_dir] = {
                                'Best Iteration': best_iteration,
                                'Best Response': best_response_number,
                                'Rank of Best Response': rank_of_best_response,
                                'Time to Generate': time_to_generate,
                                'Total Calls': total_calls
                            }

    return data

# Process each directory and store the results in a list
for model, root_dir in zip(models, root_dirs):
    model_data = process_directory(root_dir, model)
    all_data.append((model, model_data))

# Initialize a list to store DataFrames for each model
dfs = []

# Convert the data for each model to a pandas DataFrame
for model, data in all_data:
    columns = []
    for candidate in sorted(data.keys()):
        for depth in sorted(data[candidate].keys()):
            columns.append((candidate, f'depth{depth}', 'Best Iteration'))
            columns.append((candidate, f'depth{depth}', 'Best Response'))
            columns.append((candidate, f'depth{depth}', 'Rank of Best Response'))
            columns.append((candidate, f'depth{depth}', 'Time to Generate'))
            columns.append((candidate, f'depth{depth}', 'Total Calls'))  # New column for total calls

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
                    row.append(data[candidate][depth][prompt]['Total Calls'])  # Append total calls
                else:
                    row.extend([None, None, None, None, None])
        df_data.append(row)

    df = pd.DataFrame(df_data, index=sorted(prompts), columns=multi_index)

    # Calculate the total number of "1"s and percentage of "1"s in the "Rank of Best Response" columns
    total_ones_data = []
    percent_ones_data = []
    average_data = []
    avg_llm_calls = []  # New list for average LLM calls

    for candidate in sorted(data.keys()):
        num_candidates = int(candidate[3:])  # Extract number of candidates
        for depth in sorted(data[candidate].keys()):
            for metric in ['Best Iteration', 'Best Response', 'Rank of Best Response', 'Time to Generate', 'Total Calls']:
                if metric == 'Rank of Best Response':
                    rank_col = (candidate, f'depth{depth}', metric)
                    if rank_col in df.columns:
                        total_ones = df[rank_col].eq(1).sum()
                        percent_ones = total_ones / len(df[rank_col])
                        non_negative_values = df[rank_col][df[rank_col] >= 0]
                        average_value = non_negative_values.mean() if not non_negative_values.empty else None
                    else:
                        total_ones = 0
                        percent_ones = 0
                        average_value = None
                    total_ones_data.append(total_ones)
                    percent_ones_data.append(percent_ones)
                    average_data.append(average_value)
                    avg_llm_calls.append(None)

                elif metric == 'Total Calls':
                    total_calls_col = (candidate, f'depth{depth}', metric)
                    if total_calls_col in df.columns:
                        avg_calls = df[total_calls_col].mean()
                    else:
                        avg_calls = 0
                    avg_llm_calls.append(avg_calls)
                    total_ones_data.append(None)
                    percent_ones_data.append(None)
                    average_data.append(None)

                else:
                    total_ones_data.append(None)
                    percent_ones_data.append(None)
                    average_data.append(None)
                    avg_llm_calls.append(None)

    # Add the summary statistics to the DataFrame
    summary_df = pd.DataFrame([total_ones_data, percent_ones_data, average_data, avg_llm_calls], columns=multi_index, index=['Total number of 1s', 'Percent Ones', 'Average Rank', 'Avg LLM Calls'])
    df = pd.concat([df, summary_df])

    # Save the DataFrame to a list
    dfs.append((model, df))

# Read additional models from the CSV file
#additional_models_df = pd.read_csv(csv_file_path)
#
## Strip any whitespace from the column names
#additional_models_df.columns = additional_models_df.columns.str.strip()
#
## Define markers and colors for additional models
#additional_markers = ['^', 'v']
#additional_colors = ['purple', 'orange']

# Plotting
plt.figure(figsize=(8, 6))  # Adjusted figure size to be more compact

# Define markers and colors for different models
markers = ['o', 's', 'D']
colors = ['b', 'g', 'r']

texts = []
for (model, df), marker, color in zip(dfs, markers, colors):
    x_values = []
    y_values = []
    x_values_depth0 = []
    y_values_depth0 = []
    points = []
    labels = []
    labels_depth0 = []
    for candidate in sorted(data.keys(), key=lambda x: int(x[3:])):
        num_candidates = int(candidate[3:])  # Extract number of candidates
        for depth in sorted(data[candidate].keys(), key=int):
            percent_ones_col = (candidate, f'depth{depth}', 'Rank of Best Response')
            avg_llm_calls_col = (candidate, f'depth{depth}', 'Total Calls')
            if percent_ones_col in df.columns and avg_llm_calls_col in df.columns:
                percent_ones = df.loc['Percent Ones', percent_ones_col]
                avg_llm_calls = df.loc['Avg LLM Calls', avg_llm_calls_col]

                label = f"(k={num_candidates}, d={depth})"

                points.append((avg_llm_calls, percent_ones))
                if depth == 0:
                    x_values_depth0.append(avg_llm_calls)
                    y_values_depth0.append(percent_ones)
                    labels_depth0.append(label)
                else:
                    x_values.append(avg_llm_calls)
                    y_values.append(percent_ones)
                    labels.append(label)


    # Identify and plot Pareto points
    pareto_points = identify_pareto(points)
    pareto_x, pareto_y = zip(*pareto_points)
    plt.plot(pareto_x, pareto_y, label=f"{model} Pareto", linestyle='--', color=color)

    plt.scatter(x_values, y_values, label=model, marker=marker, color=color)
    plt.scatter(x_values_depth0, y_values_depth0, label=f"{model} (depth 0)", marker='x', color=color)

    for (x, y, label) in zip(x_values + x_values_depth0, y_values + y_values_depth0, labels+labels_depth0):
        text = plt.text(x, y, label)
        texts.append(text)

adjust_text(texts, only_move={'points':'y', 'text':'xy'}, arrowprops=dict(arrowstyle="->", color='grey', lw=0.75), force_static=(0.05,0.05))

## Add additional models to the plot
#for model, marker, color in zip(additional_models_df['Model'].unique(), additional_markers, additional_colors):
#    model_data = additional_models_df[additional_models_df['Model'] == model]
#    plt.scatter(model_data['Effort'], model_data['Accuracy'], label=model, marker=marker, color=color)
#
#    # Identify and plot Pareto points for additional models
#    additional_points = list(zip(model_data['Effort'], model_data['Accuracy']))
#    pareto_points = identify_pareto(additional_points)
#    pareto_x, pareto_y = zip(*pareto_points)
#    plt.plot(pareto_x, pareto_y, label=f"{model} Pareto", linestyle='--', marker='x', color=color)
#
plt.xlabel('Average LLM Queries', fontsize=20, weight='bold')
plt.ylabel('Accuracy (% Success)', fontsize=20, weight='bold')
plt.title('Effort vs Accuracy - Machine Benchmarks', fontsize=22, weight='bold')
plt.legend(fontsize=16, loc='lower right')
plt.grid(True)
plt.tight_layout()  # Reduce whitespace around the plot
plt.show()

