import os
import re
import json
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load benchmark categories from JSON file
with open('categories.json', 'r') as f:
    benchmark_categories = json.load(f)

# Flatten the JSON structure into a dictionary mapping benchmarks to their subcategories
benchmark_to_subcategory = {}
subcategory_to_topcategory = {}
for top_level, sub_levels in benchmark_categories.items():
    for sub_level, benchmarks in sub_levels.items():
        subcategory_to_topcategory[sub_level] = top_level
        for benchmark in benchmarks:
            benchmark_to_subcategory[benchmark] = sub_level

# Define the list of root directories where the data is stored
root_dirs = ['../full_results/gpt-4o', '../full_results/gpt3.5_turbo_16k', '../full_results/claude-3-haiku-20240307']
models = ['GPT-4o', 'GPT-3.5T', 'Haiku']

# Regular expression patterns to extract the required information
time_pattern = re.compile(r"Time to Generate: ([\d\.eE+-]+)")
best_iteration_pattern = re.compile(r"Best ranked response at iteration (\d+) with response number (\d+)")
rank_pattern = re.compile(r"Rank of best response: ([\d\.eE+-]+)")

# Function to process a single directory
def process_directory(root_dir, model_name):
    data = []
    for candidate_depth_dir in os.listdir(root_dir):
        candidate_depth_path = os.path.join(root_dir, candidate_depth_dir)
        if os.path.isdir(candidate_depth_path):
            candidate_depth_parts = candidate_depth_dir.split('_')
            if len(candidate_depth_parts) == 2 and candidate_depth_parts[0].startswith('can') and candidate_depth_parts[1].startswith('depth'):
                candidate = candidate_depth_parts[0]
                depth = int(candidate_depth_parts[1][5:])  # Extract numerical depth value

                human_dir_path = os.path.join(candidate_depth_path, 'human')

                for prompt_dir in os.listdir(human_dir_path):
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

                            if prompt_dir in benchmark_to_subcategory:
                                subcategory = benchmark_to_subcategory[prompt_dir]
                                topcategory = subcategory_to_topcategory[subcategory]
                                data.append({
                                    'Model': model_name,
                                    'Candidate': candidate,
                                    'Depth': depth,
                                    'Benchmark': prompt_dir,
                                    'Subcategory': subcategory,
                                    'Topcategory': topcategory,
                                    'Best Iteration': best_iteration,
                                    'Best Response': best_response_number,
                                    'Rank of Best Response': rank_of_best_response,
                                    'Time to Generate': time_to_generate,
                                    'Total Calls': total_calls
                                })

    return data

# Process each directory and store the results in a list
all_data = []
for model, root_dir in zip(models, root_dirs):
    model_data = process_directory(root_dir, model)
    all_data.extend(model_data)

# Convert to DataFrame
df = pd.DataFrame(all_data)

# Calculate success percent for each subcategory, candidate, and depth
df['Success'] = df['Rank of Best Response'] == 1
df_summary = df.groupby(['Model', 'Candidate', 'Depth', 'Subcategory', 'Topcategory']).agg({
    'Success': 'mean',
    'Benchmark': 'count'
}).reset_index().rename(columns={'Success': 'Success Percent', 'Benchmark': 'Total Benchmarks'})

# Define the top-level categories of interest
topcategories_of_interest = ['Verilog Language', 'Combinational Logic', 'Sequential Logic', 'Verification: Reading Simulations']

# Create subplots
fig, axes = plt.subplots(nrows=len(models), ncols=1, figsize=(18, 4 * len(models)), sharex=True, sharey=True)

# Flatten axes array if necessary
if len(models) == 1:
    axes = [axes]

# Plotting each model in its own subplot
for bigindex,(ax, model) in enumerate(zip(axes, models)):
    df_model = df_summary[df_summary['Model'] == model]

    # Use the order of subcategories as they appear in the JSON file
    subcategories = []
    for topcategory in topcategories_of_interest:
        subcategories.extend(benchmark_categories[topcategory].keys())
    num_subcategories = len(subcategories)
    bar_width = 0.1
    space_between_subcategories = 0.2  # Space between subcategories
    space_between_topcategories = 0.5  # Space between top-level categories

    candidates_depths = df_model.groupby(['Candidate', 'Depth']).size().index.tolist()
    num_bars = len(candidates_depths)

    positions = []
    current_position = 0
    for topcategory in topcategories_of_interest:
        subcategory_list = list(benchmark_categories[topcategory].keys())
        positions.extend([current_position + i * (bar_width * num_bars + space_between_subcategories) for i in range(len(subcategory_list))])
        current_position += len(subcategory_list) * (bar_width * num_bars + space_between_subcategories) + space_between_topcategories

    # Define a color palette with enough distinct colors
    palette = sns.color_palette("tab20", num_bars)

    # Ensure the data is in the correct order and remove NaN subcategories
    df_model['Subcategory'] = pd.Categorical(df_model['Subcategory'], categories=subcategories, ordered=True)
    df_model = df_model.dropna(subset=['Subcategory']).sort_values('Subcategory')

    for i, (candidate, depth) in enumerate(candidates_depths):
        df_cd = df_model[(df_model['Candidate'] == candidate) & (df_model['Depth'] == depth)]
        x_positions = [positions[subcategories.index(subcat)] + i * bar_width for subcat in df_cd['Subcategory']]
        ax.bar(x_positions, df_cd['Success Percent'] * 100, bar_width, label=f'{candidate}, Depth {depth}', color=palette[i])

    # Draw lines and labels to separate top-level categories
    current_position = 0
    for index, topcategory in enumerate(topcategories_of_interest):
        subcategory_list = list(benchmark_categories[topcategory].keys())
        mid_position = current_position + (len(subcategory_list) * (bar_width * num_bars + space_between_subcategories)) / 2
        if index < len(topcategories_of_interest) - 1:
            ax.axvline(x=(current_position + len(subcategory_list) * (bar_width * num_bars + space_between_subcategories) + (space_between_topcategories/2) - (bar_width*1.5)), color='gray', linestyle='--')

        if bigindex == 2:
            ax.text(mid_position - (space_between_topcategories / 2), -140, topcategory, horizontalalignment='center', fontsize=18, weight='bold')

        current_position += len(subcategory_list) * (bar_width * num_bars + space_between_subcategories) + space_between_topcategories

    ax.set_ylabel('% Success', fontsize=18, weight='bold')
    ax.set_title(f'{model}', fontsize=18, weight='bold')
    #ax.legend()
    if bigindex == 0:
        ax.legend(bbox_to_anchor=(0,1.15,1,0),loc='lower left', mode="expand", ncol=6, fontsize=16)
        #ax.legend()

# Set x-axis labels and ticks for the bottom subplot only
axes[-1].set_xticks([positions[subcategories.index(subcat)] + (num_bars - 1) * bar_width / 2 for subcat in subcategories])
axes[-1].set_xticklabels(subcategories, rotation=45, fontsize=18, ha='right', weight='bold', rotation_mode='anchor')

#plt.xlabel('Subcategory')
#ax.text(mid_position - (space_between_topcategories / 2), -15, topcategory, horizontalalignment='center', fontsize=18, weight='bold')
#plt.legend()
plt.tight_layout()
plt.show()

### # Create the plot for each model
### for model in models:
###     plt.figure(figsize=(28, 8))  # Increased width to prevent overlap
###     df_model = df_summary[df_summary['Model'] == model]
###
###     # Use the order of subcategories as they appear in the JSON file
###     subcategories = []
###     for topcategory in topcategories_of_interest:
###         subcategories.extend(benchmark_categories[topcategory].keys())
###     num_subcategories = len(subcategories)
###     bar_width = 0.1
###     space_between_subcategories = 0.25  # Space between subcategories
###     space_between_topcategories = 1  # Space between top-level categories
###
###     candidates_depths = df_model.groupby(['Candidate', 'Depth']).size().index.tolist()
###     num_bars = len(candidates_depths)
###
###     positions = []
###     current_position = 0
###     for topcategory in topcategories_of_interest:
###         subcategory_list = list(benchmark_categories[topcategory].keys())
###         positions.extend([current_position + i * (bar_width * num_bars + space_between_subcategories) for i in range(len(subcategory_list))])
###         current_position += len(subcategory_list) * (bar_width * num_bars + space_between_subcategories) + space_between_topcategories
###
###     # Adjusting positions to remove extra spaces
###     #total_width = current_position - space_between_topcategories  # Total width minus the last space_between_topcategories
###     #positions = [pos / total_width * (total_width + space_between_topcategories) for pos in positions]
###
###     # Define a color palette with enough distinct colors
###     palette = sns.color_palette("tab20", num_bars)
###
###     # Ensure the data is in the correct order and remove NaN subcategories
###     df_model['Subcategory'] = pd.Categorical(df_model['Subcategory'], categories=subcategories, ordered=True)
###     df_model = df_model.dropna(subset=['Subcategory']).sort_values('Subcategory')
###
###     for i, (candidate, depth) in enumerate(candidates_depths):
###         df_cd = df_model[(df_model['Candidate'] == candidate) & (df_model['Depth'] == depth)]
###         x_positions = [positions[subcategories.index(subcat)] + i * bar_width for subcat in df_cd['Subcategory']]
###         plt.bar(x_positions, df_cd['Success Percent'] * 100, bar_width, label=f'{candidate}, Depth {depth}', color=palette[i])
###
###     # Draw lines and labels to separate top-level categories
###     current_position = 0
###     for index,topcategory in enumerate(topcategories_of_interest):
###         subcategory_list = list(benchmark_categories[topcategory].keys())
###         mid_position = current_position + (len(subcategory_list) * (bar_width * num_bars + space_between_subcategories)) / 2
###         if index < len(topcategories_of_interest) - 1:
###             plt.axvline(x=(current_position + len(subcategory_list) * (bar_width * num_bars + space_between_subcategories) + (space_between_topcategories/2) - (bar_width*1.5)), color='gray', linestyle='--')
###         plt.text(mid_position - (space_between_topcategories / 2),
###                  -15, topcategory, horizontalalignment='center', fontsize=14, weight='bold')
###         current_position += len(subcategory_list) * (bar_width * num_bars + space_between_subcategories) + space_between_topcategories
###
###     #plt.xlabel('Subcategory')
###     plt.ylabel('Success Percent')
###     plt.title(f'Success Percent by Subcategory for {model}')
###     plt.xticks([positions[subcategories.index(subcat)] + (num_bars - 1) * bar_width / 2 for subcat in subcategories], subcategories, rotation=45)
###     plt.legend()
###     plt.tight_layout()
###     plt.show()
