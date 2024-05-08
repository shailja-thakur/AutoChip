#!../venv/bin/python3

import subprocess
import languagemodels as lm
import conversation as cv
import os
import sys
import getopt
from time import time
import re
from threading import Timer


# def find_verilog_modules(markdown_string, module_name='top_module'):
#     # Convert the input to a string
#     markdown_string = str(markdown_string)
#
#     # This pattern captures the entire code block with the module definition
#     code_block_pattern = r'```verilog(.*?)```'
#     code_blocks = re.findall(code_block_pattern, markdown_string, re.DOTALL)
#
#     # If no code blocks found, return an empty list
#     if not code_blocks:
#         return []
#
#     # This pattern captures the module definition within the code block
#     module_pattern = rf'\bmodule\b\s+{module_name}\s*\(.*?\)\s*;(.*?)\bendmodule\b'
#
#     module_matches = []
#     for code_block in code_blocks:
#         match = re.search(module_pattern, code_block, re.DOTALL)
#         if match:
#             module_matches.append(match.group())
#
#     return module_matches


def find_verilog_modules(markdown_string):

    module_pattern = r'\bmodule\b\s+\w+\s*\([^)]*\)\s*;.*?endmodule\b'
    parameter_module_pattern = r'\bmodule\b\s+\w+\s*#\s*\([^)]*\)\s*\([^)]*\)\s*;.*?endmodule\b'

    module_matches = re.findall(module_pattern, markdown_string, re.DOTALL)

    parameter_module_matches = re.findall(parameter_module_pattern, markdown_string, re.DOTALL)

    all_module_matches = module_matches + parameter_module_matches

    if not all_module_matches:
        return []

    return all_module_matches

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

def generate_verilog(conv, model_type, model_id=""):
    ## TODO: Change to switch case
    if model_type == "ChatGPT4":
        model = lm.ChatGPT4()
    elif model_type == "Claude":
        model = lm.Claude()
    elif model_type == "ChatGPT3p5":
        model = lm.ChatGPT3p5()
    elif model_type == "Gemini":
        model = lm.Gemini()
    elif model_type == "Human":
        model = lm.HumanInput()
    elif model_type == "Mistral":
        model = lm.Mistral()
    elif model_type == "CodeLLama":
        model = lm.CodeLlama(model_id)
    else:
        raise ValueError("Invalid model type")

    return(model.generate(conv))

def verilog_loop(design_prompt, module, testbench, max_iterations, model_type, outdir="", log=None):

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

    filename = os.path.join(outdir,module+".sv")

    status = ""
    while not (success or timeout):
        start_time = time()
        # Generate a response
        response = generate_verilog(conv, model_type)
        end_time = time()

        llm_response_time = end_time - start_time

        conv.add_message("assistant", response)

        write_code_blocks_to_file(response, module, filename)

        vvp_file = os.path.join(outdir,module+".vvp")
        compiler_cmd = f"iverilog -Wall -Winfloop -Wno-timescale -g2012 -s tb -o {vvp_file} {filename} {testbench}"
        simulator_cmd = f"vvp -n {vvp_file}"

        proc = subprocess.run(compiler_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

        ## Check compilation error
        if proc.returncode != 0:
            status = "Compilation error"
            print(status)
            message = "The design failed to compile. Please fix the module. The output of iverilog is as follows:\n"+proc.stderr

        elif proc.stderr != "":
            status = "Compilation warning"
            print(status)
            message = "The design compiled with warnings. Please fix the module. The output of iverilog is as follows:\n"+proc.stderr

        else:
            proc = subprocess.run(simulator_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
            result = proc.stdout.strip().split('\n')[-1].split()
            print(result)

            if result[1] != '0':
                status = "Mismatches in simulation: "+result[1]+" in "+result[3]+" samples"
                print(status)
                message = "The testbench simulated, but had errors. Please fix the module. The output of iverilog is as follows:\n"+proc.stdout

            else:
                status = "Testbench ran successfully"
                print(status)
                message = ""
                success = True

################################
        with open(os.path.join(outdir,"log_iter_"+str(iterations)+".txt"), 'w') as file:
            file.write('\n'.join(str(i) for i in conv.get_messages()))
            file.write('\n\n Iteration status: ' + status + '\n')


        if not success:
            if iterations > 0:
                conv.remove_message(2)
                conv.remove_message(2)

            #with open(testbench, 'r') as file: testbench_text = file.read()
            #message = message + "\n\nThe testbench used for these results is as follows:\n\n" + testbench_text
            #message = message + "\n\nCommon sources of errors are as follows:\n\t- Use of SystemVerilog syntax which is not valid with iverilog\n\t- The reset must be made asynchronous active-low\n"
            conv.add_message("user", message)

        if iterations >= max_iterations:
            timeout = True

        iterations += 1

def main():
    usage = "Usage: auto_create_verilog.py [--help] --prompt=<prompt> --name=<module name> --testbench=<testbench file> --iter=<iterations> --model=<llm model> --model_id=<model id> --log=<log file>\n\n\t-h|--help: Prints this usage message\n\n\t-p|--prompt: The initial design prompt for the Verilog module\n\n\t-n|--name: The module name, must match the testbench expected module name\n\n\t-t|--testbench: The testbench file to be run\n\n\t-i|--iter: [Optional] Number of iterations before the tool quits (defaults to 10)\n\n\t-m|--model: The LLM to use for this generation. Must be one of the following\n\t\t- ChatGPT3p5\n\t\t- ChatGPT4\n\t\t- Claude\n\n\t- CodeLLama\n\n\t-l|--log: [Optional] Log the output of the model to the given file"

    try:
        opts, args = getopt.getopt(sys.argv[1:], "hp:n:t:i:m:o:l:", ["help", "prompt=", "name=", "testbench=", "iter=", "model=", "outdir=","log="])
    except getopt.GetoptError as err:
        print(err)
        print(usage)
        sys.exit(2)


    # Default values
    max_iterations = 10

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print(usage)
            sys.exit()
        elif opt in ("-p", "--prompt"):
            prompt = arg
        elif opt in ("-n", "--name"):
            module = arg
        elif opt in ("-t", "--testbench"):
            testbench = arg
        elif opt in ("-i", "--iter"):
            max_iterations = int(arg)
        elif opt in ("-m", "--model"):
            model = arg
        elif opt in ("-o", "--outdir"):
            outdir = arg
        elif opt in ("-l", "--log"):
            log = arg


    # Check if prompt and module are set
    try:
        prompt
    except NameError:
        print("Prompt not set")
        print(usage)
        sys.exit(2)

    try:
        module
    except NameError:
        print("Module not set")
        print(usage)
        sys.exit(2)

    try:
        testbench
    except NameError:
        print("Testbench not set")
        print(usage)
        sys.exit(2)

    try:
        model
    except NameError:
        print("LLM not set")
        print(usage)
        sys.exit(2)

    try:
        outdir
    except NameError:
        outdir = ""

    if outdir != "":
        if not os.path.exists(outdir):
            os.makedirs(outdir)

    verilog_loop(prompt, module, testbench, max_iterations, model, outdir, log)

if __name__ == "__main__":
    main()
