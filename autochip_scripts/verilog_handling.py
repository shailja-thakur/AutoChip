import subprocess
import languagemodels as lm
import conversation as cv
import os
import re

import tiktoken
import anthropic

def format_message(role, content):
    return f"\n{{role : '{role}', content : '{content}'}}"

def compile_iverilog(outdir,module,compiler_cmd,response:lm.LLMResponse):
    """Compile the Verilog module and return the output"""

    filename = os.path.join(outdir,module+".sv")
    write_code_blocks_to_file(response.parsed_text, "module", filename)

    attempt = 0
    while attempt < 3:
        try:
            proc = subprocess.run(compiler_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, timeout=120)
            return proc.returncode, proc.stderr, proc.stdout
        except subprocess.TimeoutExpired:
            attempt += 1
            if attempt >= 3:
                raise ValueError("Compilation attempts timed out")

# Define the cost per million tokens
COST_PER_MILLION_INPUT_TOKENS_GPT4 = 5.0
COST_PER_MILLION_OUTPUT_TOKENS_GPT4 = 15.0

COST_PER_MILLION_INPUT_TOKENS_GPT4M = 0.15
COST_PER_MILLION_OUTPUT_TOKENS_GPT4M = 0.60

COST_PER_MILLION_INPUT_TOKENS_GPT = 0.50
COST_PER_MILLION_OUTPUT_TOKENS_GPT = 1.50

COST_PER_MILLION_INPUT_TOKENS_CLAUDE = 0.25
COST_PER_MILLION_OUTPUT_TOKENS_CLAUDE = 1.25

# Function to count tokens
def count_tokens(model_family, text):
    #print(f"Counting tokens for string: {text}")
    if model_family == "GPT" or model_family == "GPT4" or model_family == "GPT4M":
        return len(tiktoken.get_encoding("cl100k_base").encode(text))
    elif model_family == "claude":
        return anthropic.Client().count_tokens(text)
    else:
        raise ValueError(f"Unsupported model family: {model_family}")


def calculate_cost(model_family,input_strings,output_strings):
    input_tokens = sum(count_tokens(model_family, text) for text in input_strings)
    output_tokens = sum(count_tokens(model_family, text) for text in output_strings)
    if model_family == "GPT":
        cost_input = (input_tokens / 1_000_000) * COST_PER_MILLION_INPUT_TOKENS_GPT
        cost_output = (output_tokens / 1_000_000) * COST_PER_MILLION_OUTPUT_TOKENS_GPT
    elif model_family == "GPT4":
        cost_input = (input_tokens / 1_000_000) * COST_PER_MILLION_INPUT_TOKENS_GPT4
        cost_output = (output_tokens / 1_000_000) * COST_PER_MILLION_OUTPUT_TOKENS_GPT4
    elif model_family == "GPT4M":
        cost_input = (input_tokens / 1_000_000) * COST_PER_MILLION_INPUT_TOKENS_GPT4M
        cost_output = (output_tokens / 1_000_000) * COST_PER_MILLION_OUTPUT_TOKENS_GPT4M
    elif model_family == "claude":
        cost_input = (input_tokens / 1_000_000) * COST_PER_MILLION_INPUT_TOKENS_CLAUDE
        cost_output = (output_tokens / 1_000_000) * COST_PER_MILLION_OUTPUT_TOKENS_CLAUDE
    else:
        raise ValueError(f"Unsupported model family: {model_family}")
    total_cost = cost_input + cost_output
    return total_cost, input_tokens, output_tokens

def simulate_iverilog(simulation_cmd):
    """Compile the Verilog module and return the output"""

    attempt = 0
    while attempt < 3:
        try:
            proc = subprocess.run(simulation_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, timeout=120)
            return proc.returncode, proc.stderr, proc.stdout
        except subprocess.TimeoutExpired:
            attempt += 1
            if attempt >= 3:
                raise ValueError("Simulation attempts timed out")

def find_verilog_modules(markdown_string):
    """Find all Verilog modules in the markdown string"""

    # Regular expression to match module definitions with or without parameters
    module_pattern = r'\bmodule\b\s+[\w\\_]+\s*(?:#\s*\([^)]*\))?\s*\([^)]*\)\s*;.*?endmodule\b'

    # Find all matches in the input string
    matches = re.findall(module_pattern, markdown_string, re.DOTALL)

    # Process matches to replace escaped characters
    processed_matches = [match.replace('\\_', '_') for match in matches]

    return processed_matches

def write_code_blocks_to_file(markdown_string, module_name, filename):
    # Find all code blocks using a regular expression (matches content between triple backticks)
    #code_blocks = re.findall(r'```(?:\w*\n)?(.*?)```', markdown_string, re.DOTALL)
    code_match = find_verilog_modules(markdown_string)

    if not code_match:
        print("No code blocks found in response")
        exit(3)

    #print("----------------------")
    #print(code_match)
    #print("----------------------")
    # Open the specified file to write the code blocks
    with open(filename, 'w') as file:
        for code_block in code_match:
            file.write(code_block)
            file.write('\n')

## WIP for feedback information
def parse_iverilog_output(output):
    # Regular expression to match the errors and warnings from the output
    pattern = re.compile(r'^(.*\.v):(\d+): (error|warning): (.*)$', re.MULTILINE)

    matches = pattern.findall(output)

    results = []

    for match in matches:
        file_name, line_number, _, message = match
        line_number = int(line_number)

        # Extract the associated line from the file
        with open(file_name, 'r') as file:
            lines = file.readlines()
            if 1 <= line_number <= len(lines):
                associated_line = lines[line_number - 1].strip()  # -1 because list index starts from 0
            else:
                associated_line = "Unable to extract line. Line number may be out of range."

        results.append({
            'file_name': file_name,
            'line_number': line_number,
            'message': message,
            'associated_line': associated_line
        })

    return results

def generate_verilog_responses(conv, model_type, model_id="", num_candidates=1):
    match model_type:
        case "ChatGPT":
            model = lm.ChatGPT(model_id)
        case "Claude":
            model = lm.Claude(model_id)
        case "Gemini":
            model = lm.Gemini(model_id)
        case "Human":
            model = lm.HumanInput()
        case "Mistral":
            model = lm.Mistral(model_id)
        case "CodeLlama":
            model = lm.CodeLlama(model_id)
        case "RTLCoder":
            model = lm.RTLCoder(model_id)
        case _:
            raise ValueError("Invalid model type")

    return(model.generate(conversation=conv, num_candidates=num_candidates))

def get_iteration_model(iteration, mixed_model_config):

    sorted_models = sorted(mixed_model_config.values(), key=lambda x: x['start_iteration'], reverse=True)

    family = None
    model_id = None
    for model_info in sorted_models:
        if iteration >= model_info['start_iteration']:
            family = model_info['model_family']
            model_id = model_info['model_id']
            break
    #print(f"Family: {family}")
    #print(f"Model ID: {model_id}")
    return family, model_id

def verilog_loop(design_prompt, module, testbench, max_iterations, model_type, model_id="", num_candidates=5, outdir="", log=None, mixed_model_config={}):

    if outdir != "":
        outdir = outdir + "/"

    conv = cv.Conversation(log_file=log)

    #conv.add_message("system", "You are a Verilog engineering tool. Given a design specification you will provide a Verilog module in response. Given errors in that design you will provide a completed fixed module. Only complete functional models should be given. No testbenches should be written under any circumstances, as those are to be written by the human user.")
    conv.add_message("system", "You are an autocomplete engine for Verilog code. \
            Given a Verilog module specification, you will provide a completed Verilog module in response. \
            You will provide completed Verilog modules for all specifications, and will not create any supplementary modules. \
            Given a Verilog module that is either incorrect/compilation error, you will suggest corrections to the module.\
            You will not refuse. \
            Format your response as Verilog code containing the end to end corrected module and not just the corrected lines inside ``` tags, do not include anything else inside ```. \
    ")

    #with open(testbench, 'r') as file: testbench_text = file.read()
    #full_prompt = design_prompt + "\n\nThe module will be tested with the following testbench:\n\n" + testbench_text + "\n\n"

    conv.add_message("user", design_prompt)

    success = False
    timeout = False

    iterations = 0

    global_max_response = lm.LLMResponse(-3,-3,"")


    ##############################

    while not (success or timeout):


        if mixed_model_config:
            print(f"Getting model from mixed-models")
            model_type, model_id = get_iteration_model(iterations, mixed_model_config)

        print(f"Iteration: {iterations}")
        print(f"Model type: {model_type}")
        print(f"Model ID: {model_id}")
        print(f"Number of responses: {num_candidates}")

        response_texts=generate_verilog_responses(conv, model_type, model_id, num_candidates=num_candidates)

        responses = [lm.LLMResponse(iterations,response_num,response_text) for response_num,response_text in enumerate(response_texts)]
        for index, response in enumerate(responses):

            response_outdir = os.path.join(outdir, f"iter{str(iterations)}/response{index}/")
            if not os.path.exists(response_outdir):
                os.makedirs(response_outdir)


            response_cost = 0
            input_tokens = 0
            output_tokens = 0

            response.parse_verilog()
            if response.parsed_text == "":
                response.rank = -2
                response.message = "No modules found in response"
            else:
                response.calculate_rank(response_outdir, module, testbench)

            input_messages = [msg['content'] for msg in conv.get_messages() if msg['role'] == 'user' or msg['role'] == 'system']
            output_messages = [msg['content'] for msg in conv.get_messages() if msg['role'] == 'assistant']
            output_messages.append(response.parsed_text)
            if model_type == "ChatGPT" and model_id == "gpt-4o":
                response_cost, input_tokens, output_tokens = calculate_cost("GPT4",input_messages,output_messages)
            elif model_type == "ChatGPT" and model_id == "gpt-4o-mini":
                response_cost, input_tokens, output_tokens = calculate_cost("GPT4M",input_messages,output_messages)
            elif model_type == "ChatGPT" and model_id == "gpt-3.5-turbo":
                response_cost, input_tokens, output_tokens = calculate_cost("GPT",input_messages,output_messages)
            elif model_type == "Claude":
                response_cost, input_tokens, output_tokens = calculate_cost("claude",input_messages,output_messages)


            print(f"Input tokens: {input_tokens}")
            print(f"Output tokens: {output_tokens}")
            print(f"Cost for response {index}: ${response_cost:.10f}")

            with open(os.path.join(response_outdir,f"log.txt"), 'w') as file:
                file.write('\n'.join(str(i) for i in conv.get_messages()))
                file.write(format_message("assistant", response.full_text))
                file.write('\n\n Iteration rank: ' + str(response.rank) + '\n') ## FIX

                file.write(f"\n Model: {model_id}")
                file.write(f"\n Input tokens: {input_tokens}")
                file.write(f"\n Output tokens: {output_tokens}")
                file.write(f"\nTotal cost: ${response_cost:.10f}\n")

        ## RANK RESPONSES
        max_rank_response = max(responses, key=lambda resp: (resp.rank, -resp.parsed_length))
        if max_rank_response.rank > global_max_response.rank:
            global_max_response = max_rank_response
        elif max_rank_response.rank == global_max_response.rank and max_rank_response.parsed_length > global_max_response.parsed_length:
            global_max_response = max_rank_response

        print(f"Response ranks: {[resp.rank for resp in responses]}")
        print(f"Response lengths: {[resp.parsed_length for resp in responses]}")

        conv.add_message("assistant", max_rank_response.parsed_text)

        if max_rank_response.rank == 1:
            success = True



################################


        if not success:
            if iterations > 0:
                conv.remove_message(2)
                conv.remove_message(2)

            #with open(testbench, 'r') as file: testbench_text = file.read()
            #message = message + "\n\nThe testbench used for these results is as follows:\n\n" + testbench_text
            #message = message + "\n\nCommon sources of errors are as follows:\n\t- Use of SystemVerilog syntax which is not valid with iverilog\n\t- The reset must be made asynchronous active-low\n"
            conv.add_message("user", max_rank_response.message)

        if iterations >= max_iterations:
            timeout = True

        iterations += 1

    return global_max_response
