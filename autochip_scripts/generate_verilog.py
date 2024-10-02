import config_handler as c
import verilog_handling as vh

from time import time

def main():
    """Main function to execute the program logic."""
    config_values, mixed_model_config, logfile = c.parse_args_and_config()

    # ## SHOULD ALREADY BE HANDLED
    # required_keys = ['name', 'testbench', 'model']
    # missing_keys = [key for key in required_keys if key not in config_values or not config_values[key]]

    # if missing_keys:
    #     print(f"Missing required configuration: {', '.join(missing_keys)}")
    #     print(open("usage.txt", "r").read())
    #     sys.exit(2)

    ## Determine the prompt source
    #if 'prompt-editor' in config_values and config_values['prompt-editor']:
    #    prompt = c.get_prompt_from_editor(config_values['prompt-editor'])
    #elif 'prompt' in config_values and config_values['prompt']:
    #    with open(config_values['prompt'], 'r') as file:
    #        prompt = file.read()
    #else:
    #    print("Either prompt or prompt-editor must be set")
    #    print(open("usage.txt", "r").read())
    #    sys.exit(2)

    # Use the parsed values as needed
    prompt_file = config_values['prompt']
    module = config_values['name']
    testbench = config_values['testbench']
    family = config_values.get('model_family',None)
    model_id = config_values.get('model_id', None)
    iterations = config_values['iterations']
    num_candidates = config_values['num_candidates']
    outdir = config_values['outdir']
    log = config_values['log']

    with open(prompt_file, 'r') as file:
        prompt = file.read()

    # Example use of the parsed values and ensemble config
    # print(
    #     f"Prompt: {prompt}\nModule: {module}\nTestbench: {testbench}\n"
    #     f"Num Candidates: {num_candidates}\n"
    #     f"Outdir: {outdir}\nLog: {log}\nMax Iterations: {iterations}\n"
    # )
    # print(
    #         f"Model: {family}\nModel ID: {model_id}\n"
    # )


    # print(f"Ensemble Configuration:\n{ensemble_config}")

    #for i in range(iterations):
    #    print(f"Iteration {i}")
    #    vh.get_iteration_ensemble(i, ensemble_config)

    start_time = time()
    max_response = vh.verilog_loop(design_prompt=prompt, module=module, testbench=testbench, max_iterations = iterations, model_type=family, model_id=model_id, num_candidates=num_candidates, outdir=outdir, log=logfile, mixed_model_config=mixed_model_config)
    end_time = time()
    generation_time = end_time - start_time

    try:
        with open(logfile, 'a') as file:
            file.write(f"Time to Generate: {generation_time}\n")
            file.write(f"Best ranked response at iteration {max_response.iteration} with response number {max_response.response_num}\n")
            file.write(f"Rank of best response: {max_response.rank}\n")
            file.write(f"Best response module:\n{max_response.parsed_text}\n")
    except:
        pass

    #print("Ensemble Configuration:")
    #for model_name, model_config in ensemble_config.items():
    #    print(f"{model_name}: Start Iteration = {model_config['start_iteration']}, Model Path = {model_config['model']}")

if __name__ == "__main__":
    main()

