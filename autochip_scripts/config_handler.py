import json
import os
import subprocess
import tempfile
import sys
import getopt

def load_config(config_file="config.json"):
    """Load and validate the configuration from the specified JSON file."""
    with open(config_file, 'r') as file:
        config = json.load(file)

    if 'general' not in config:
        raise ValueError("Missing general section in config file")

    config_values = config['general']

    # Only parse mixed-model settings if specified
    parse_mixed_models = config_values.get('mixed-models', False)
    mixed_model_config = {}
    if parse_mixed_models:
        mixed_model_config = config.get('mixed-models', {})

    #return config_values
    return config_values, mixed_model_config


def validate_mixed_model_config(mixed_model_config, max_iterations):
    seen_start_iterations = set()
    adjusted_config = {}
    has_start_at_zero = False

    for model_name, model_info in mixed_model_config.items():
        start_iteration = model_info['start_iteration']

        # Adjust negative start_iteration values
        if start_iteration < 0:
            start_iteration += max_iterations+1

        # Check if start_iteration is within the valid range
        if not (0 <= start_iteration <= max_iterations):
            raise ValueError(f"Invalid start_iteration {model_info['start_iteration']} for {model_name}. "
                             f"Must be within the range of 0 to {max_iterations} or valid negative index.")

        # Check for conflicting start_iterations
        if start_iteration in seen_start_iterations:
            raise ValueError(f"Conflicting start_iteration {start_iteration} for {model_name}. "
                             f"Another model already uses this start iteration.")
        seen_start_iterations.add(start_iteration)

        # Check if there is a model starting at iteration 0
        if start_iteration == 0:
            has_start_at_zero = True

        # Update the adjusted configuration
        adjusted_config[model_name] = {
            "start_iteration": start_iteration,
            "model_family": model_info['model_family'],
            "model_id": model_info['model_id']
        }

        if not has_start_at_zero:
            raise ValueError("No model starting at iteration 0 in the mixel-model configuration. One model must start at iteration 0.")

    return adjusted_config


def parse_args_and_config():
    """Parse command-line arguments and merge them with configuration file values."""
    usage = open("usage.txt", "r").read()

    try:
        opts, _ = getopt.getopt(
            sys.argv[1:],
            "hc:p:e:n:t:i:f:m:k:o:l:",
            [
                "help", "config=", "prompt=", "prompt-editor=", "name=", "testbench=",
                "iter=", "model-family=", "model-id=", "num-candidates=",
                "outdir=", "log="
            ]
        )
    except getopt.GetoptError as err:
        print(err)
        print(usage)
        sys.exit(2)

    config_file = "config.json"

    # First pass: Check for config file argument
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print(usage)
            sys.exit()
        elif opt in ("-c", "--config"):
            config_file = arg

    # Load config values from the file
    config_values, mixed_model_config = load_config(config_file)

    # Override config values with command line arguments if provided
    for opt, arg in opts:
        if opt in ("-p", "--prompt"):
            config_values['prompt'] = arg
        #elif opt in ("-e", "--prompt-editor"):
        #    config_values['prompt-editor'] = arg
        elif opt in ("-n", "--name"):
            config_values['name'] = arg
        elif opt in ("-t", "--testbench"):
            config_values['testbench'] = arg
        elif opt in ("-i", "--iter"):
            config_values['iterations'] = int(arg)
        elif opt in ("-f", "--model-family"):
            config_values['model_family'] = arg
        elif opt in ("-m", "--model-id"):
            config_values['model_id'] = arg
        elif opt in ("-k", "--num-candidates"):
            config_values['num_candidates'] = int(arg)
        elif opt in ("-o", "--outdir"):
            config_values['outdir'] = arg
        elif opt in ("-l", "--log"):
            config_values['log'] = arg


    required_values = ['prompt', 'name', 'testbench', 'outdir', 'log']
    if not mixed_model_config:
        required_values +=['model_family', 'model_id']

    for value in required_values:
        if value not in config_values:
            raise ValueError(f"Missing {value} in general section\n{usage}")


    # general values for optional config values
    if 'num_candidates' not in config_values:
        config_values['num_candidates'] = 1
    if 'iterations' not in config_values:
        config_values['iterations'] = 10


    if mixed_model_config:
        mixed_model_config = validate_mixed_model_config(mixed_model_config, config_values['iterations'])

    # Ensure outdir exists
    if config_values['outdir']:
        os.makedirs(config_values['outdir'], exist_ok=True)

    logfile = os.path.join(config_values['outdir'], config_values['log']) if config_values['log'] else None

    #return config_values, logfile
    return config_values, mixed_model_config, logfile

def get_prompt_from_editor(editor_command="nano"):
    """Open a text editor to get the prompt input from the user."""
    with tempfile.NamedTemporaryFile(suffix=".tmp") as temp_file:
        temp_file_path = temp_file.name
        subprocess.call([editor_command, temp_file_path])
        temp_file.seek(0)
        prompt_text = temp_file.read().decode('utf-8')
    return prompt_text

