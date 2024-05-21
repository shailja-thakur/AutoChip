#!../venv/bin/python3

import subprocess
import languagemodels as lm
import conversation as cv
import os
import sys
import getopt
from time import time
import re

class LLMResponse():
    """Class to store the response from the LLM"""
    def __init__(self, full_text):
        self.full_text = full_text
        self.tokens = 0

        self.parsed_text = ""
        self.parsed_length = 0

        self.feedback = ""
        self.compiled = False
        self.rank = 0
        self.message = ""

    def set_parsed_text(self, parsed_text):
        self.parsed_text = parsed_text
        self.parsed_length = len(parsed_text)

    def parse_verilog(self):
        module_list = find_verilog_modules(self.full_text)
        if not module_list:
            print("No modules found in response")
            exit(3)
        for module in module_list:
            self.parsed_text += module + "\n\n"
        self.parsed_length = len(self.parsed_text)

    def calculate_rank(self, outdir, module, testbench):
        filename = os.path.join(outdir,module+".sv")
        vvp_file = os.path.join(outdir,module+".vvp")

        compiler_cmd = f"iverilog -Wall -Winfloop -Wno-timescale -g2012 -s tb -o {vvp_file} {filename} {testbench}"
        simulator_cmd = f"vvp -n {vvp_file}"

        comp_return,comp_err,comp_out = compile_iverilog(outdir,module,compiler_cmd,self)

        if comp_return != 0:
            self.feedback = comp_err
            self.compiled = False
            print("Compilation error")
            self.message = "The design failed to compile. Please fix the module. The output of iverilog is as follows:\n"+comp_err

            self.rank = -1

        elif comp_err != "":
            self.feedback = comp_err
            self.compiled = True
            print("Compilation warning")
            self.message = "The design compiled with warnings. Please fix the module. The output of iverilog is as follows:\n"+comp_err

            self.rank = -0.5

        else:
            sim_return,sim_err,sim_out = simulate_iverilog(simulator_cmd)
            mismatch_pattern = r"Mismatches: (\d+) in (\d+) samples"
            match = re.search(mismatch_pattern, sim_out.splitlines()[-1])
            print(f"Match: {match}")

            if match:
                mismatches = int(match.group(1))
                samples = int(match.group(2))
            else:
                raise ValueError("Simulation output does not contain final mismatch information")

            if mismatches > 0:
                self.feedback = sim_out
                self.compiled = True
                print("Simulation error")
                self.message = "The testbench simulated, but had errors. Please fix the module. The output of iverilog is as follows:\n"+sim_out
            else:
                self.compiled = True
                print("Testbench ran successfully")
                self.message = "The testbench completed successfully"

            print(f"Mismatches: {mismatches}")
            print(f"Samples: {samples}")
            self.rank = (samples-mismatches)/samples

        #return self.rank



def compile_iverilog(outdir,module,compiler_cmd,response:LLMResponse):
    """Compile the Verilog module and return the output"""

    filename = os.path.join(outdir,module+".sv")
    write_code_blocks_to_file(response.parsed_text, "module", filename)
    proc = subprocess.run(compiler_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    return proc.returncode, proc.stderr, proc.stdout

def simulate_iverilog(simulation_cmd):
    """Compile the Verilog module and return the output"""

    proc = subprocess.run(simulation_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    return proc.returncode, proc.stderr, proc.stdout

def find_verilog_modules(markdown_string):
    """Find all Verilog modules in the markdown string"""

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

def generate_verilog(conv, model_type, model_id="", num_responses=1):
    match model_type:
        case "ChatGPT":
            model = lm.ChatGPT(model_id)
            print(f"Using ChatGPT model with id {model_id}")
        ##case "Claude":
        ##    model = lm.Claude(model_id)
        ##case "Gemini":
        ##    model = lm.Gemini(model_id)
        ##case "Human":
        ##    model = lm.HumanInput()
        ##case "Mistral":
        ##    model = lm.Mistral(model_id)
        ##case "CodeLLama":
        ##    model = lm.CodeLlama(model_id)
        case _:
            raise ValueError("Invalid model type")

    return(model.generate(conversation=conv, num_choices=num_responses))

def verilog_loop(design_prompt, module, testbench, max_iterations, model_type, num_responses=5, model_id="", outdir="", log=None):

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

    ##############################

    status = ""
    while not (success or timeout):

        print(f"Model type: {model_type}")
        print(f"Model ID: {model_id}")
        print(f"Number of responses: {num_responses}")

        start_time = time()
        # Generate a response
        response_texts=generate_verilog(conv, model_type, model_id, num_responses=num_responses)
        end_time = time()
        llm_response_time = end_time - start_time

        responses = [LLMResponse(response_text) for response_text in response_texts]
        for index, response in enumerate(responses):

            response_outdir = os.path.join(outdir, f"iter{str(iterations)}/response{index}/")
            if not os.path.exists(response_outdir):
                os.makedirs(response_outdir)

            response.parse_verilog()
            response.calculate_rank(response_outdir, module, testbench)

            with open(os.path.join(response_outdir,f"log.txt"), 'w') as file:
                file.write('\n'.join(str(i) for i in conv.get_messages()))
                file.write('\n\n Iteration status: ' + status + '\n') ## FIX

        ## RANK RESPONSES
        max_rank_response = max(responses, key=lambda resp: (resp.rank, -resp.parsed_length))

        print(f"Response ranks: {[resp.rank for resp in responses]}")
        print(f"Response lengths: {[resp.parsed_length for resp in responses]}")

        conv.add_message("assistant", max_rank_response.parsed_text)

        if max_rank_response.rank == 1:
            success = True
            status = "Success"



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

    print(max_rank_response.parsed_text)


def main():
    usage = "Usage: auto_create_verilog.py [--help] --prompt=<prompt> --name=<module name> --testbench=<testbench file> --iter=<iterations> --model=<llm model> --model_id=<model id> --log=<log file>\n\n\t-h|--help: Prints this usage message\n\n\t-p|--prompt: The initial design prompt for the Verilog module\n\n\t-n|--name: The module name, must match the testbench expected module name\n\n\t-t|--testbench: The testbench file to be run\n\n\t-i|--iter: [Optional] Number of iterations before the tool quits (defaults to 10)\n\n\t-m|--model: The LLM to use for this generation. Must be one of the following\n\t\t- ChatGPT3p5\n\t\t- ChatGPT4\n\t\t- Claude\n\n\t- CodeLLama\n\n\t-l|--log: [Optional] Log the output of the model to the given file"

    try:
        opts, args = getopt.getopt(sys.argv[1:], "hp:n:t:i:m:o:l:", ["help", "prompt=", "name=", "testbench=", "iter=", "model=", "model-id=", "outdir=","log="])
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
        elif opt in ("--model-id"):
            model_id = arg
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
        model_id
    except NameError:
        model_id = ""

    try:
        outdir
    except NameError:
        outdir = ""

    if outdir != "":
        if not os.path.exists(outdir):
            os.makedirs(outdir)

    verilog_loop(design_prompt=prompt, module=module, testbench=testbench, max_iterations=max_iterations, model_type=model, model_id=model_id, outdir=outdir, log=log)

if __name__ == "__main__":
    main()
