import json
import os
import re

def modify_testbench(file_path):
    with open(file_path, 'r') as file:
        content = file.read()

    # Find all 'logic' declarations
    signals = re.findall(r'\blogic\b\s+\b(?P<signal_name>\w+)\b;', content)

    # Create the display line part for each signal
    display_parts = ['{}=%b'.format(signal) for signal in signals]
    display_line = '$display("Mismatch at time %0d: ' + ' '.join(display_parts) + '", $time, ' + ', '.join(signals) + ');'

    # Define the pattern to find the mismatch handling block
    mismatch_pattern = re.compile(r'(if\s*\(!tb_match.*?\)\s*begin)((?:[^e]|e(?!nd))*?)', re.DOTALL)

    # Function to insert display line just before the first 'end' in the mismatch block
    def replacement(match):
        inner_block = match.group(2)
        position = inner_block.rfind('end')  # Find the last occurrence of 'end' that closes the block
        return match.group(1) + '\n            ' + inner_block[:position].strip() + '\n            ' + display_line + '\n            ' + inner_block[position:]

    modified_content = mismatch_pattern.sub(replacement, content)

    # Write the modified content back to the file
    with open(file_path, 'w') as file:
        file.write(modified_content)

    print(f"Testbench {file_path} modified successfully.")



def parse_and_save_json(tasks_json_path, descriptions_json_path):
    # Load detailed descriptions from the second JSON file into a dictionary
    descriptions = {}
    with open(descriptions_json_path, 'r') as desc_file:
        for line in desc_file:
            desc_data = json.loads(line)
            formatted_description = "// " + desc_data['detail_description']
            descriptions[desc_data['task_id']] = formatted_description

    # Read and process the original tasks JSON file
    with open(tasks_json_path, 'r') as tasks_file:
        for line in tasks_file:
            data = json.loads(line)
            task_id = data['task_id']

            # Create a directory for each task
            directory = os.path.join('VerilogEval_separated_files', task_id)
            os.makedirs(directory, exist_ok=True)

            # Combine detail_description with the prompt
            combined_prompt = descriptions.get(task_id, '') + '\n\n' + data['prompt']

            # Save combined prompt to a file
            with open(os.path.join(directory, f"{task_id}.sv"), 'w') as prompt_file:
                prompt_file.write(combined_prompt)

            # Save canonical solution
            with open(os.path.join(directory, 'canonical_solution.txt'), 'w') as solution_file:
                solution_file.write(data['canonical_solution'])

            # Save test setup
            with open(os.path.join(directory, f"{task_id}_tb.sv"), 'w') as test_file:
                test_file.write(data['test'])

            modify_testbench(os.path.join(directory, f"{task_id}_tb.sv"))

# Example usage:
# Replace 'tasks_json_file.json' and 'descriptions_json_file.json' with your actual file paths
parse_and_save_json("VerilogEval_Human.jsonl","VerilogDescription_Human.jsonl")
