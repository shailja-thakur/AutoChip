#!/usr/bin/env python
# coding: utf-8



# Required Libraries
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import glob
import os
import numpy as np


import shutil
import re

# Step 1: Extract the contents of the ZIP file.

extracted_dir = "Verilog-Practice"

# Step 2: Identify all `.v` files and their respective paths.
verilog_files = []
for root, dirs, files in os.walk(extracted_dir):
    for file in files:
        if file.endswith(".v"):
            verilog_files.append(os.path.join(root, file))

# Step 3: Clean the names and create mappings between the given list and the files extracted from the ZIP.

def clean_filename(filename):
    # Remove numbers followed by underscores
    cleaned_name = re.sub(r"\d+_", "", filename)
    return cleaned_name

mapping = {}
cleaned=[]
for verilog_path in verilog_files:
    cleaned_name = clean_filename(os.path.basename(verilog_path))
    cleaned.append(cleaned_name)
print(cleaned)


# Cleaning the file names for each chunk and combining them
cleaned_files = []

cleaned_files.extend([re.sub(r"^[.:\s]+", "", file_name).replace(':','/').replace(" ",'_') for file_name in cleaned])

for f in cleaned_files:
    print(f)





# Scan the extracted directory again to identify all the .v files
verilog_files = []
flattened_dir="Verilog-Practice"
for file in glob.glob(os.path.join(extracted_dir, '**', '*.v'), recursive=True):
    # for file in files:
    if file.endswith(".v"):
        verilog_files.append(file)
print(verilog_files)
# Copying all the .v files to the flattened directory
for verilog_path in verilog_files:
    dest_path = os.path.join(flattened_dir, os.path.basename(verilog_path))
    
    # Ensure unique file names by appending numbers if the file already exists
    counter = 1
    while os.path.exists(dest_path):
        base, ext = os.path.splitext(os.path.basename(verilog_path))
        dest_path = os.path.join(flattened_dir, f"{base}{ext}")
        counter += 1
    
    shutil.copy(verilog_path, dest_path)

# Counting the number of .v files in the flattened directory
flattened_verilog_files = [file for file in os.listdir(flattened_dir) if file.endswith(".v")]




for file_name in glob.glob(os.path.join(extracted_dir, '*.v'), recursive=True):
    file_name = os.path.basename(file_name)
    new_name = re.sub(r'\d+_', '', file_name)  # Remove the pattern
    old_path = os.path.join(flattened_dir, file_name)
    new_path = os.path.join(flattened_dir, new_name)
    
    os.rename(old_path, new_path)



# Renaming the files by filtering out the pattern (number followed by "_")
for file_name in glob.glob(os.path.join(extracted_dir, '*.v'), recursive=True):
    file_name = os.path.basename(file_name)
    new_name=file_name.replace(" ",'_')
    old_path = os.path.join(flattened_dir, file_name)
    new_path = os.path.join(flattened_dir, new_name)
    
    os.rename(old_path, new_path)
    



def get_report(response,first=False):
    
    
    # # Parse the HTML code
    soup = BeautifulSoup(response, 'html.parser')
    # print(soup)
    # Find the container element
    container = soup.find('div', id='container')
    # print(container)
    report=[]
    compile_msg=[]
    headers=soup.find_all(re.compile('^h[1-6]$'))
    
    # Find all the messages with the specified text
    head = container.find_all('span', text='Running Quartus synthesis.')
    
    # Find all the messages with the 'msg_none' class
    messages = soup.find_all('span', class_=lambda value: value and value.startswith('msg'))
    
    # print(messages)
    
    timing_diagrams=[]
        
    status=None
    # print(messages)
    for header in headers:
        

        if 'Timing diagrams' in header.text:
            
            script_wavedrom = container.find_all('script', type='WaveDrom')
            # print(script_wavedrom)
            for script in script_wavedrom:
                
                script_text = script.text

                timing_diagrams.append(script_text)
            
        
        
            # print('status in condition',status)
        if 'Status: Success' in header.text:
            
            status=header.text
       

    return status, timing_diagrams



import requests
from bs4 import BeautifulSoup
import glob
import numpy as np
import os
import re

base_dir=os.path.join(os.getcwd())


if not os.path.exists(os.path.join(os.getcwd(),'Verilog-Practice','hdlbits_waveforms')):
    
    os.mkdir(os.path.join(base_dir,'Verilog-Practice','hdlbits_waveforms'))
                      
                                 
import json

def get_prompt(solution_file):
    
    prompt_files = glob.glob(os.path.join('verilog_problem_set', '*.v'), recursive=True)
    
    for prompt_file in prompt_files:
        problem=os.path.basename(solution_file).split('.')[0].split(':')[-1].lower()
        
        if problem in prompt_file:
            prompt = open(prompt_file,'r').read()
            return prompt
        
        



import re

def extract_module_block(verilog_code):
    # print(verilog_code)
    # first try to find 'top_module'
    top_module_pattern = r"(module top_module.*?endmodule)"
    matches = re.findall(top_module_pattern, verilog_code, re.DOTALL)
    if matches:
        return matches[0]  # Return the first 'top_module'
    
    # if 'top_module' isn't found, find any other module
    any_module_pattern = r"(module.*?endmodule)"
    matches = re.findall(any_module_pattern, verilog_code, re.DOTALL)
    # print(matches)
    if matches:
        return matches[0]  # Return the first module found
    
    # if no module is found, return False
    return False

import datetime



# Create a session object to handle cookies
session = requests.Session()

# URL of the web page to scrape
url = 'https://hdlbits.01xz.net/wiki/Special:VlgStats'

# Send a GET request to the URL and get the HTML content
response = session.get(url)


with open('problem_links.txt','r') as f:
            problem_links = f.read()
        
problem_links = problem_links.split('\n')

# solution_files = cleaned
solution_files = glob.glob(os.path.join(os.getcwd(),'../ChipChat','hdlbits_solutions', '*.v'), recursive=True)

for solution_file in solution_files:

    # if 'Sim:circuihigh.v' in solution_file or '2012_q2fsm.v' in solution_file:
    #     continue

    # if 'Lfsr32.v' in solution_file or 'Rule90.v' in solution_file or 'Fsm1s.v' in solution_file: 
    
    if os.path.exists(os.path.join(os.getcwd(),'Verilog-Practice','hdlbits_waveforms',solution_file.split('/')[-1].split('.')[0]+'_'+str(0)+'.json')):
        
        print(solution_file.split('/')[-1].split('.')[0]+'_'+str(0), 'exists')
        continue
    
    print(solution_file)
    
    # if 'Fsm1s' in solution_file:
    try:
        print(os.path.join(os.getcwd(),'Verilog-Practice','hdlbits_testbenches',solution_file))

        problem_link = '/wiki/'+os.path.basename(solution_file).split('.')[0].replace(':','/')

        problem_link = 'https://hdlbits.01xz.net' + problem_link 

        print(f"Submitting solution for {problem_link}...")
        # Send a GET request to the problem link and get the HTML content

        response = requests.get(problem_link)
        html_content = response.content

        # Parse the HTML content with BeautifulSoup
        soup = BeautifulSoup(html_content, 'html.parser')

        window = soup.find('h3', text='Write your solution here').parent

        # Find the form inside the window
        form = window.find('form')

        # Change the text part of the window to 'print(1)'
        text_input = form.find('textarea')

        formatted_strings = []


        solution_text = open(solution_file).read()

        # solution_text=extract_module_block(solution_text)

        if solution_text is None: continue

        text_input.string = solution_text

        # Get the form action URL
        form_action = form['action']

        # Extract other form elements
        form_data = {}
        for input_elem in form.find_all('input',type='hidden'):
            # print(input_elem)
            name = input_elem.get('name')
            value = input_elem.get('value')
            form_data[name] = value

        # Update the form data with the changed text
        form_data[text_input['name']] = text_input.string


        # Submit the form to the original URL using the session
        action = form.get("action")

        submit_url='https://hdlbits.01xz.net'+ action

        response = session.post(submit_url, data=form_data)

        if response.status_code == 200:
            print(f"Form submitted successfully! {solution_file}")
            # print(response.content)
            # dump the response as txt file
            content = response.content.decode('utf-8')  # Assuming the content is in UTF-8 encoding
            print(content)
            status, timing_diagram = get_report(content)
            print(solution_text)
            print(timing_diagram)


            print(status)

            if len(timing_diagram)>0:
                for i,timing in enumerate(timing_diagram):
                    with open(os.path.join(os.getcwd(),'Verilog-Practice','hdlbits_waveforms',solution_file.split('/')[-1].split('.')[0]+'_'+str(i)+'.json'),'w') as f:
                        f.write(timing)
                        f.close()

        else:
            print(f"Form submission failed for {solution_file}")

    except Exception as e:
        print(os.path.join(base_dir,'hdlbits_testbenches',solution_file))
        print(e)




# In[ ]:


# solution_files = cleaned
prompt_files = glob.glob(os.path.join(os.getcwd(),'../ChipChat','hdlbits_prompts', '*.v'), recursive=True)

for prompt_file in prompt_files:

        
    if os.path.exists(os.path.join(os.getcwd(),'Verilog-Practice','hdlbits_waveforms',solution_file.split('/')[-1].split('.')[0]+'_'+str(0)+'.json')):
        print('exists')
        continue
    
    print(solution_file)


# In[ ]:





# In[162]:


os.getcwd()


# In[ ]:





def interpret_wave(wave, data=None):
    """
    Interpret the wave pattern based on the provided explanations.
    """
    interpretation = []
    previous_state = None
    
    # Mapping of characters to their interpretations
    mapping = {
        'l': 'Low',
        'h': 'High',
        '0': 'Low',
        '1': 'High',
        '=': 'Transition',
        'x': 'Undefined',
        '.': 'Continuation'
    }
    
    data_idx = 0  # to keep track of data list index
    
    for char in wave:
        if char == '.':
            interpretation.append(previous_state)
        elif char == '=':
            interpretation.append(f"Transition to {data[data_idx]}")
            previous_state = f"Value {data[data_idx]}"
            data_idx += 1
        else:
            interpretation.append(mapping[char])
            previous_state = mapping[char]
    
    return interpretation

# Apply the interpretation function to the wave column
df['interpretation'] = df.apply(lambda row: interpret_wave(row['wave'], row['data']), axis=1)



def value_only_wave(wave, data=None):
    """
    Interpret the wave pattern to display only the values.
    """
    values = []
    previous_value = None
    
    # Mapping of characters to their values
    mapping = {
        'l': 'Low',
        'h': 'High',
        '0': '0',
        '1': '1',
        '=': 'Transition',
        'x': 'x',
        '.': 'Continuation'
    }
    
    data_idx = 0  # to keep track of data list index
    
    for char in wave:
        if char == '.':
            values.append(previous_value)
        elif char == '=':
            values.append(data[data_idx])
            previous_value = data[data_idx]
            data_idx += 1
        else:
            values.append(mapping[char])
            previous_value = mapping[char]
    
    return values

# Extracting the tick marks (time periods) from the foot section
ticks = [tspan for tspan in data["foot"]["tick"]]
print(ticks)

# Calculate the number of tick entries
num_ticks = len(ticks)

# Generate a range of tick values
tick_range = range(num_ticks)

# Applying the value_only_wave function to the wave column
df['values'] = df.apply(lambda row: value_only_wave(row['wave'], row['data']), axis=1)

# Creating a table with time periods and values
time_period_table = pd.DataFrame(index=tick_range)

for index, row in df.iterrows():
    time_period_table[row['category'] + '-' + row['name']] = row['values']



import pandas as pd








def generate_testbench(module_name, inputs, generated_outputs, reference_outputs):
    testbench = ""

    # Add module header
    testbench += f"module {module_name}_tb;\n\n"
    
  
    # Declare inputs and outputs
    input_decl = ""
    for col in inputs_cols:
        input_name = col.replace('Inputs-', '')
        if input_name in input_bit_widths:
            input_decl += f"    reg [{input_bit_widths[input_name]-1}:0] {input_name};\n"
        else:
            input_decl += f"    reg {input_name};\n"
            
    output_decl = ""
    for col in generated_output_cols:
        output_name = col.replace('Yours-', '')
        if output_name in output_bit_widths:
            output_decl += f"    wire [{output_bit_widths[output_name]-1}:0] {output_name};\n"
        else:
            output_decl += f"    wire {output_name};\n"
            
    testbench += f"{input_decl}\n{output_decl}\n\n"
    
    # Instantiate DUT
    dut_instance = f"    {module_name} dut ("
    dut_ports = [f".{col.replace('Inputs-', '')}({col.replace('Inputs-', '')})" for col in inputs_cols]
    dut_ports.extend([f".{col.replace('Yours-', '')}({col.replace('Yours-', '')})" for col in generated_output_cols])
    dut_instance += ", ".join(dut_ports)
    dut_instance += ");"
    testbench += f"    {dut_instance}\n\n"
    
    # Initial block for testing
    testbench += "    initial begin\n"
    testbench += "        integer mismatch_count;\n"
    testbench += "        mismatch_count = 0;\n\n"
    
    for i in range(len(inputs)):
        # input_values = ", ".join([f"{col.replace('Inputs-', '')} = {input_bit_widths[col]}'h{int(value, 16)}" if value != 'x' else f"{col.replace('Inputs-', '')} = {input_bit_widths[col]}'bx" for col, value in inputs.iloc[i].items()])
        input_values = ", ".join([f"8'h{int(value, 16)}" if value != 'x' else "8'bx" for value in inputs.iloc[i]])
        
        # Read generated and reference outputs for this iteration
        gen_output_values = generated_outputs.iloc[i]
        ref_output_values = reference_outputs.iloc[i]
        
        # Create lists to hold the formatted values for gen_outputs and ref_outputs
        gen_outputs = []
        ref_outputs = []
        
        # Iterate over the values and format them
        for gen_value, ref_value in zip(gen_output_values, ref_output_values):
            # if gen_value == 'x':
            #     gen_outputs.append("8'bx")
            # else:
            #     gen_outputs.append(f"8'h{int(gen_value, 16)}")
            
            
            if ref_value == 'x':
                ref_outputs.append("8'bx")
            else:
                ref_outputs.append(f"8'h{int(ref_value, 16)}")
        
        for gen_output_col in generated_output_cols:
            gen_outputs.append(f"{generated_output_col.replace('Yours-', '')}")
        
        # Create strings from the lists
        gen_output_str = ", ".join(gen_outputs)
        ref_output_str = ", ".join(ref_outputs)
        
        testbench += f"        // Tick {i}: Inputs = {input_values}, Generated = {gen_output_str}, Reference = {ref_output_str}\n"
        
        # Set input values
        # testbench += f"        {input_values};\n"
        
        input_assignments = []
        for j, input_col in enumerate(inputs_cols):
            input_value = inputs.iloc[i][input_col]
            if input_value == 'x':
                input_assignments.append(f"{input_col.replace('Inputs-', '')} = 8'bx")
            else:
                input_assignments.append(f"{input_col.replace('Inputs-', '')} = 8'h{int(input_value, 16)}")
        testbench += f"        {'; '.join(input_assignments)}; // Set input values\n"


        # Add time delay
        testbench += f"        wait(1);\n"
        
        # Compare generated outputs against reference outputs
        outputs_comparison = " && ".join([f"{gen_output} === {ref_output}" for gen_output, ref_output in zip(gen_outputs, ref_outputs)])
        testbench += f"        if (!({outputs_comparison})) begin\n"
        testbench += f"            $display(\"Mismatch at index {i}: Inputs = {input_values}, Generated = {gen_outputs}, Reference = {ref_outputs}\");\n"
        testbench += "            mismatch_count = mismatch_count + 1;\n"
        testbench += "        end\n\n"
    
    # Display success or mismatch count
    testbench += "        if (mismatch_count == 0)\n"
    testbench += "            $display(\"All tests passed!\");\n"
    testbench += "        else\n"
    testbench += f"            $display(\"%0d mismatches out of %0d total tests.\", mismatch_count, {len(generated_outputs)});\n"
    testbench += "        $finish;\n"
    testbench += "    end\n\n"
    
    testbench += "endmodule"
    
    return testbench



# Read the DataFrame (replace this with your data source)
# Extract inputs and outputs column names
input_cols = [col for col in time_period_table.columns if col.startswith("Inputs-")]
generated_output_cols = [col for col in time_period_table.columns if col.startswith("Yours-")]
reference_output_cols = [col for col in time_period_table.columns if col.startswith("Ref-")]

# Extract inputs and outputs data
inputs = time_period_table[input_cols]
generated_outputs = time_period_table[generated_output_cols]
reference_outputs = time_period_table[reference_output_cols]

print(input_cols, generated_output_cols, inputs, generated_outputs, reference_outputs)
input_bit_widths, output_bit_widths = extract_bit_widths(verilog_module)
print("Input Bit Widths:", input_bit_widths)
print("Output Bit Widths:", output_bit_widths)

module_name = "top_module"  # Replace with your actual module name
generated_testbench = generate_testbench(module_name, inputs, generated_outputs, reference_outputs)

# generated_testbench = generate_testbench(module_name, input_bit_widths, output_bit_widths, inputs, generated_outputs, reference_outputs)
print(generated_testbench)



def extract_bit_widths(verilog_module_block):
    # Extract input and output declarations from the module block
    input_matches = re.findall(r"input\s+\[([0-9]+)\s*:\s*[0-9]+\]\s+(\w+)", verilog_module_block)
    output_matches = re.findall(r"output\s+\[([0-9]+)\s*:\s*[0-9]+\]\s+(\w+)", verilog_module_block)
    
    # Create dictionaries to store bit widths of inputs and outputs
    input_bit_widths = {name: int(width) for width, name in input_matches}
    output_bit_widths = {name: int(width) for width, name in output_matches}
    
    return input_bit_widths, output_bit_widths


for file in solution_files:
    # if 'Mux9to1v.v' in file:
    try:
        with open(file,'r') as f:
            verilog_module=f.read()

        input_bit_widths, output_bit_widths = extract_bit_widths(verilog_module)
        print("Input Bit Widths:", input_bit_widths)
        print("Output Bit Widths:", output_bit_widths)

        # read the waveform
        
        wave_files = glob.glob(os.path.join(os.getcwd(),'Verilog-Practice','hdlbits_waveforms','*.json'))
        # print(wave_files)
        # Filter wave files based on filenames
        # filename_without_extension = [os.path.splitext(os.path.basename(wave_file))[0] for wave_file in wave_files]
        # waves = [wave_file for wave_file in wave_files if filename_without_extension in wave_file]

        waves = [wave_file for wave_file in wave_files if file.split('/')[-1].split('.')[0] in wave_file.split('/')[-1].split('.')[0]]
        
        for wave in waves:
            
            with open(wave,'r') as f:
                data=json.loads(f.read())
            
            print(signal['signal'])

        # Extract signal data
        signals = data["signal"]

        # Extracted list to store signal information
        signal_list = []

        for group in signals:
            if isinstance(group, list):
                category = group[0]
                for signal in group[1:]:
                    signal["category"] = category
                    signal_list.append(signal)

        # Convert extracted signal data into a DataFrame
        df = pd.DataFrame(signal_list)

        # Apply the interpretation function to the wave column
        df['interpretation'] = df.apply(lambda row: interpret_wave(row['wave'], row['data']), axis=1)

        # Extracting the tick marks (time periods) from the foot section
        ticks = [tspan for tspan in data["foot"]["tick"]]
        print(ticks)

        # Calculate the number of tick entries
        num_ticks = len(ticks)

        # Generate a range of tick values
        tick_range = range(num_ticks)

        # Applying the value_only_wave function to the wave column
        df['values'] = df.apply(lambda row: value_only_wave(row['wave'], row['data']), axis=1)

        # Creating a table with time periods and values
        time_period_table = pd.DataFrame(index=tick_range)

        for index, row in df.iterrows():
            time_period_table[row['category'] + '-' + row['name']] = row['values']

        print(time_period_table)
#         input_cols = [col for col in time_period_table.columns if col.startswith("Inputs-")]
#         generated_output_cols = [col for col in time_period_table.columns if col.startswith("Yours-")]
#         reference_output_cols = [col for col in time_period_table.columns if col.startswith("Ref-")]

#         # Extract inputs and outputs data
#         inputs = time_period_table[input_cols]
#         generated_outputs = time_period_table[generated_output_cols]
#         reference_outputs = time_period_table[reference_output_cols]

#         print(input_cols, generated_output_cols, inputs, generated_outputs, reference_outputs)
#         input_bit_widths, output_bit_widths = extract_bit_widths(verilog_module)
#         print("Input Bit Widths:", input_bit_widths)
#         print("Output Bit Widths:", output_bit_widths)

#         module_name = "top_module"  # Replace with your actual module name
#         generated_testbench = generate_testbench(module_name, inputs, generated_outputs, reference_outputs)

#         # generated_testbench = generate_testbench(module_name, input_bit_widths, output_bit_widths, inputs, generated_outputs, reference_outputs)
#         print(generated_testbench)

    except Exception as e:
        print(e)






