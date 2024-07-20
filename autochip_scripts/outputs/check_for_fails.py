import os
import re

# Define the root directory where the data is stored
#root_dir = './hansolo_results/claude-3-haiku-20240307/machine'
#root_dir = './reruns/claude-3-haiku-20240307_RERUNS/machine'
#root_dir = './full_results/gpt3.5_turbo_16k_complete/machine'
root_dir = '/home/jason/documents/research/llm_hardware_design/autochip/AutoChip/greedy-tree/autochip_scripts/outputs/hansolo_results/gpt3.5_turbo_16k_zeroshot/human'

# Regular expression patterns to extract the required information
time_pattern = re.compile(r"Time to Generate: (-?[\d\.]+)")
best_iteration_pattern = re.compile(r"Best ranked response at iteration (\d+) with response number (\d+)")
rank_pattern = re.compile(r"Rank of best response: (-?[\d\.]+)")

# List to store prompt directories missing required data
missing_data_prompts = []

print(root_dir)

# Walk through the prompt directories
for prompt_dir in os.listdir(root_dir):
    prompt_path = os.path.join(root_dir, prompt_dir)
    log_file = os.path.join(prompt_path, 'log.txt')

    if os.path.exists(log_file):
        with open(log_file, 'r') as f:
            lines = f.readlines()

            # Initialize flags to check for required data
            found_time = False
            found_best_iteration = False
            found_rank = False

            for line in lines:
                if time_pattern.search(line):
                    found_time = True

                if best_iteration_pattern.search(line):
                    found_best_iteration = True

                if rank_pattern.search(line):
                    found_rank = True

                # If all required data is found, no need to check further
                if found_time and found_best_iteration and found_rank:
                    break

            # If any required data is missing, add the prompt directory to the list
            if not (found_time and found_best_iteration and found_rank):
                missing_data_prompts.append(prompt_dir)

# Print the names of the prompt directories missing required data
print("Prompt directories missing required data:")
for prompt in missing_data_prompts:
    print(prompt)

