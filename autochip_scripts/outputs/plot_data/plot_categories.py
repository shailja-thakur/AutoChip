import os
import re
import json
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load benchmark categories from JSON file
with open('categories.json', 'r') as f:
    benchmark_categories = json.load(f)

# Flatten the JSON structure into a dictionary mapping benchmarks to their top-level category
benchmark_to_category = {}
for top_level, sub_levels in benchmark_categories.items():
    for sub_level, benchmarks in sub_levels.items():
        for benchmark in benchmarks:
            benchmark_to_category[benchmark] = top_level

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

                            if prompt_dir in benchmark_to_category:
                                category = benchmark_to_category[prompt_dir]
                                data.append({
                                    'Model': model_name,
                                    'Candidate': candidate,
                                    'Depth': depth,
                                    'Benchmark': prompt_dir,
                                    'Category': category,
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

# Calculate success percent for each category, candidate, and depth
df['Success'] = df['Rank of Best Response'] == 1
df_summary = df.groupby(['Model', 'Candidate', 'Depth', 'Category']).agg({
    'Success': 'mean',
    'Benchmark': 'count'
}).reset_index().rename(columns={'Success': 'Success Percent', 'Benchmark': 'Total Benchmarks'})

# Create subplots
fig, axes = plt.subplots(nrows=len(models), ncols=1, figsize=(22, 5 * len(models)), sharex=True, sharey=True)

# Flatten axes array if necessary
if len(models) == 1:
    axes = [axes]

handles = []
labels = []
# Plotting each model in its own subplot
for index,(ax, model) in enumerate(zip(axes, models)):
    df_model = df_summary[df_summary['Model'] == model]

    # Use the order of categories as they appear in the JSON file
    categories = list(benchmark_categories.keys())
    num_categories = len(categories)
    bar_width = 0.1
    space_between_categories = 1.0  # Increased space between categories
    positions = [i * (bar_width * len(df_model['Candidate'].unique()) + space_between_categories) for i in range(num_categories)]

    candidates_depths = df_model.groupby(['Candidate', 'Depth']).size().index.tolist()
    num_bars = len(candidates_depths)

    # Define a color palette with enough distinct colors
    palette = sns.color_palette("tab20", num_bars)

    # Ensure the data is in the correct order
    df_model['Category'] = pd.Categorical(df_model['Category'], categories=categories, ordered=True)
    df_model = df_model.sort_values('Category')

    for i, (candidate, depth) in enumerate(candidates_depths):
        df_cd = df_model[(df_model['Candidate'] == candidate) & (df_model['Depth'] == depth)]
        x_positions = [p + i * bar_width for p in positions]
        ax.bar(x_positions, df_cd['Success Percent'] * 100, bar_width, label=f'{candidate}, Depth {depth}', color=palette[i])

    ax.set_ylabel('% Success', fontsize=18, weight='bold')
    ax.set_title(f'{model}', fontsize=18, weight='bold')
    if index == 0:
        ax.legend(bbox_to_anchor=(0,1.15,1,0),loc='lower left', mode="expand", ncol=6, fontsize=16)
        #handles, labels = ax.get_legend_handles_labels()


#plt.xlabel('Category', fontsize=14, weight='bold')
#plt.legend(handles, labels, bbox_to_anchor=(1,1), loc="upper left", fontsize=16)
plt.xticks([p + (num_bars - 1) * bar_width / 2 for p in positions], categories, rotation=45, fontsize=18, ha='right', weight='bold', rotation_mode='anchor')
plt.tight_layout()
plt.show()


### # Create the plot for each model
### for model in models:
###     plt.figure(figsize=(22, 6))  # Increased width to prevent overlap
###     df_model = df_summary[df_summary['Model'] == model]
###
###     # Use the order of categories as they appear in the JSON file
###     categories = list(benchmark_categories.keys())
###     num_categories = len(categories)
###     bar_width = 0.1
###     space_between_categories = 1.0  # Increased space between categories
###     positions = [i * (bar_width * len(df_model['Candidate'].unique()) + space_between_categories) for i in range(num_categories)]
###
###     candidates_depths = df_model.groupby(['Candidate', 'Depth']).size().index.tolist()
###     num_bars = len(candidates_depths)
###
###     # Define a color palette with enough distinct colors
###     palette = sns.color_palette("tab20", num_bars)
###
###     # Ensure the data is in the correct order
###     df_model['Category'] = pd.Categorical(df_model['Category'], categories=categories, ordered=True)
###     df_model = df_model.sort_values('Category')
###
###     for i, (candidate, depth) in enumerate(candidates_depths):
###         df_cd = df_model[(df_model['Candidate'] == candidate) & (df_model['Depth'] == depth)]
###         x_positions = [p + i * bar_width for p in positions]
###         plt.bar(x_positions, df_cd['Success Percent'] * 100, bar_width, label=f'{candidate}, Depth {depth}', color=palette[i])
###
### #    plt.xlabel('Category', fontsize=14, weight='bold')
###     plt.ylabel('% Success', fontsize=14, weight='bold')
###     plt.title(f'Success Percent by Category and Combination for {model}', fontsize=16, weight='bold')
###     plt.xticks([p + (num_bars - 1) * bar_width / 2 for p in positions], categories, rotation=45, fontsize=12, ha='right', weight='bold')
###     plt.legend(loc='upper right')
###     plt.tight_layout()
###     plt.show()
###
