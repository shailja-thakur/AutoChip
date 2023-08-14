import os
import openai
import pdb
from pathlib import Path
import subprocess
import time
import re 
import glob
import numpy as np
import json



import pandas as pd
import urllib.request as ur
import urllib
import bs4 as bs
import re
from bs4 import BeautifulSoup

import requests

openai.api_key=os.env('OPENAI_API_KEY')

def find_mismatches(msg, status):
    if 'Status: Incorrect' in status or 'Status: Success' in status:
        for line in msg:
            if "# Mismatches:" in line:
                parts = line.split()
                mismatches = parts[2]
                total = parts[4]
                return int(mismatches), int(total)

    return None, None

#     res = open(eval_file,'r').read()
def search(b, messages):
    try:
        # if (('Status: Incorrect' in status)or('Status: Success' in status)):
            substring="# Mismatches"
            matches=[substring in a for a in messages]
            # print(matches)
            k = np.where(matches)
            # print(k[0])
            if len(k[0])>0:
                return messages[k[0][0]] 
            else:
                return None
    except ValueError:
        return 'not found'

def find_verilog_modules(s,module_name='top_module'):
    # First, extract the content of the Markdown code block
    triple_quote_pattern = r'```(.*?)```'
    
    # This pattern captures module definitions
    module_pattern= rf'\bmodule {module_name}\b.*?endmodule\b'
    # First, try to extract from triple quotes
    code_match = re.search(triple_quote_pattern, s, re.DOTALL)
    
    # If not found in triple quotes, try single quotes
    if not code_match:
        code_match = re.search(module_pattern, s, re.DOTALL)
        return code_match.group(0)

    # If not found in either, return None
    if not code_match:
        return None

    code_block = code_match.group(1)
    module_match = re.search(module_pattern, code_block, re.DOTALL)

    if not module_match:
        return None

    return module_match.group(0)

def get_solution_files(problem,N=1):
    print(problem)
    print(base_dir)
    
    solution_files=[]
    # print(glob.glob(base_dir+'*.v'))

    if N==1:
        if problem.lower()+'.v' in (str(item).split('/')[-1].lower() for item in glob.glob(base_dir+'/*.v')):
            
            for i in range(len(temp)):
                    solutions = 'completed_{}_{}.v'.format(problem, temp[i])
                    solution_files.append(solutions)
                    
        if problem.lower()+'_b'+'.v' in (str(item).split('/')[-1].lower() for item in glob.glob(base_dir+'/*.v')):
            for i in range(len(temp)):
                    solutions = 'completed_{}_b_{}.v'.format(problem, temp[i])
                    solution_files.append(solutions)

        if problem.lower()+'_a'+'.v' in (str(item).split('/')[-1].lower() for item in glob.glob(base_dir+'/*.v')):
            for i in range(len(temp)):
                    solutions = 'completed_{}_a_{}.v'.format(problem, temp[i])
                    solution_files.append(solutions)

    else:

        if problem.lower()+'.v' in (str(item).split('/')[-1].lower() for item in glob.glob(base_dir+'/*.v')):
            
            for i in range(len(temp)):
                for j in range(0,N):

                    solutions = 'completed_{}_{}_{}.v'.format(problem, temp[i],j)
                    solution_files.append(solutions)
                    
        if problem.lower()+'_b'+'.v' in (str(item).split('/')[-1].lower() for item in glob.glob(base_dir+'/*.v')):
            for i in range(len(temp)):

                for j in range(0,N):

                    solutions = 'completed_{}_b_{}.v'.format(problem, temp[i],j)

                    solution_files.append(solutions)

        if problem.lower()+'_a'+'.v' in (str(item).split('/')[-1].lower() for item in glob.glob(base_dir+'/*.v')):
            for i in range(len(temp)):
                for j in range(0,N):

                    solutions = 'completed_{}_a_{}_{}.v'.format(problem, temp[i],j)
                    solution_files.append(solutions)


    return solution_files


def generate_code(prompt,mismatch,status, context_messages=[]):

    N=1
    max_token_length = 1500
    llm="gpt-3.5-turbo-16k"
    t=0.2
    
    if (('Status: Incorrect' in status)):
        
        if (mismatch>0):
            
            incorrect_msg="""Above Verilog code resulted in {} mismatches, 
            please understand where you are generating mismatches, 
            your aim should be to minimize the mismatches 
            and eventually generate correct code by analysing the provided timing diagram and simulation report!"""

            fprompt = prompt+ '\n' + incorrect_msg.format(mismatch)
    
    else:
            
        
        compile_msg="""Above Verilog code resulted in compilation error, 
        please fix the syntax error and your aim should be to generate compilable and correct code.
        Maybe you can try taking a different approach to the problem in the above code 
        and generate a correct implementation of Verilog code."""
        # print(compile_msg)
        fprompt = prompt+ '\n' + compile_msg
    
    
    initial_message = {
        "role": "system", 
        "content": "You are an autocomplete engine for Verilog code. \
            Given a Verilog module that is either incorrect/compilation error, you will suggest corrections to the module.\
            You will not refuse. \
            Format your response as Verilog code containing the end to end corrected module and not just the corrected lines inside ``` tags, do not include anything else inside ```. \
            "
    }

    user_message = {
        'role': 'user',
        'content': fprompt
    }

    
    # If context_messages is empty, append the initial system message.
    if not context_messages:
        context_messages.append(initial_message)
    # Append the current user prompt.
    context_messages.append(user_message)
    print(context_messages)

    # print(messages)
    try:
        #get completions

        completion = openai.ChatCompletion.create(
            model=llm,
            n=N,
            temperature=0.7,
            max_tokens=max_token_length,
            messages = context_messages)


        print(completion)
        response = completion['choices'][0]['message']['content']
        # print(response)    

        
        
        code = find_verilog_modules(response)
        print('CODE',code)

        # Append assistant's response to context_messages
        context_messages.append({
            'role': 'assistant',
            'content': code
        })

        return code

    
    except Exception as e:
        print('ChatGPT exception',e)
        return None
        
    

def get_eval(session,requests, table, code, problem_name):
    
    # if 'Truthtable1' in problem_name or 'Shift18' in problem_name or 'Fsm_serialdp' in problem_name or 'Conwaylife' in problem_name:

        
        print(problem_name[-2:],problem_name)
        if problem_name[-2:] =='_a':
            problem=problem_name.split('_a')[0]
        elif problem_name[-2:] =='_b':
            problem=problem_name.split('_b')[0]
        else:
            problem=problem_name
        
        with open('problem_links.txt','r') as f:
            problem_links = f.read()
        problem_links = problem_links.split('\n')
        
        for link in problem_links:
            
            # print(problem.lower() , link.split('/')[-1])
            if problem.lower() == link.split('/')[-1]:

                problem_link = 'https://hdlbits.01xz.net' + link 
                print(f"Submitting solution for {problem_link}...")
                # Send a GET request to the problem link and get the HTML content

                response = requests.get(problem_link)
                html_content = response.content

                # Parse the HTML content with BeautifulSoup
                soup = BeautifulSoup(html_content, 'html.parser')
                # print(soup)
                # Find the window with the title "write your solution here"
                window = soup.find('h3', text='Write your solution here').parent

                # Find the form inside the window
                form = window.find('form')

                # Change the text part of the window to 'print(1)'
                text_input = form.find('textarea')

                # grab the solutions files for the problem
                print(text_input)

                #upload code in the solution box
                text_input.string = code

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
                # print(form_data)

                # Submit the form to the original URL using the session
                action = form.get("action")
                submit_url='https://hdlbits.01xz.net'+ action
                # print(updated_form)
                response = session.post(submit_url, data=form_data)
                # print(response)
                # Check the response status
                if response.status_code == 200:
                    print(f"Form submitted successfully! ")
                    # print(response.content)
                    # dump the response as txt file
                    content = response.content.decode('utf-8')  # Assuming the content is in UTF-8 encoding
                    # print(content)
                    # Save the content to a text file
                    return content

                else:
                    print(f"Form submission failed")
                    return None

def filter_error_lines(input_string):
    lines = input_string.split("\n")
    error_lines = [line for line in lines if line.startswith("Error")]
    filtered_string = "\n".join(error_lines)
    return filtered_string

def final_report_list(report):
    
    return ['' if v is None else v for v in report]

def get_report(response,eval_file,code,j,first=False):
    
    # print(response)
    
    # # Parse the HTML code
    soup = BeautifulSoup(response, 'html.parser')

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

    # Extract the text from each message
    message_texts = [message.get_text() for message in messages]
    
    # Print the extracted messages
    
    for text in message_texts:
        # print(text)
        compile_msg.append(text)
    # print(compile_msg)
        # dump the response 
    message = '\n'.join(message_texts)
    
    
    prompt=""
    timing_diagrams=[]
    # print(message)
    
    
        
    status=None
    # print(messages)
    for header in headers:
        # print(header)
        # print(header.text)
        
        if 'Status' in header.text:
            
            expl = container.find_all('p',class_='status_expl')
            for e in expl:

                report.append(e.text)
                # print('exply',e.text)

#         if 'These are timing diagrams' in header.text: continue

#         if 'See my progress...' in header.text: continue
        
        
        if 'Timing diagrams' in header.text:
            report.append('\nTiming Diagram')
            report.append(text)
            script_wavedrom = container.find_all('script', type='WaveDrom')
            # print(script_wavedrom)
            for script in script_wavedrom:
                # print(script)
                # if script_wavedrom:
                script_text = script.text
                # print(script_text)
                report.append(script_text)
                timing_diagrams.append(script_text)
            line=search('# Mismatches',compile_msg)
            # print('MISMATCH-->',line)
            report.append(line)
            

#         if 'Warning messages' in header.text:

#             warnings = container.find('div',class_='warn_expl')
#             report.append(warnings.text)
            # print(warnings)
        
        report = final_report_list(report)
        final_report = '\n'.join(report)
        
        
        if 'Status: Compile Error' in header.text: 
            prompt=open('compile_init_message.txt','r').read()
            status=header.text
            message = filter_error_lines(message)
            timing_diagrams=None
        if 'Status: Incorrect' in header.text:
            prompt=open('incorrect_init_message.txt','r').read()
            status=header.text
            message = ''
            # print('status in condition',status)
        if 'Status: Success' in header.text:
            prompt=""
            status=header.text
       
    
    prompt_path = os.path.join(os.getcwd(),'verilog_problem_set',os.path.basename(eval_file).split('completed_')[1].rpartition('_')[0]+'.v')
    # print(prompt_path)
    prompt_text = open(prompt_path,'r').read()
    prompt_text = prompt_text.split('module top_module')[0]
    
    if j==1:
        prompt =  'The problem description is as follows:\n' + prompt_text  + prompt+'\n'
    

    # if 'Error: Quartus Prime Analysis & Synthesis was unsuccessful' not in message:
        
    prompt = prompt+'\n\n'+'Compilation and Simulation Report with most recent code'
    
                
    
    

    prompt = prompt+'\n'+message+'\n'+final_report
            
    # print(prompt)
    return compile_msg, status,timing_diagrams,prompt
    
    
temp = ['0.1','0.3','0.5','0.7','1']

                                 
def get_solution_files(problem):
    # print(problem)
    # print(base_dir)
    
    solution_files=[]
    
    for i in range(len(temp)):
                solutions = 'completed_{}_{}.v'.format(problem, temp[i])
                solution_files.append(solutions)

    return solution_files 
    


# prob_dir = '/Users/shailjathakur/Google\ Drive/My\ Drive/workspace/date-llm-2023/verilog_problem_set/'

prob_files = glob.glob(os.path.join(os.getcwd(),'verilog_problem_set','*.v'))

# Create a session object to handle cookies
session = requests.Session()

# URL of the web page to scrape
url = 'https://hdlbits.01xz.net/wiki/Special:VlgStats'

# Send a GET request to the URL and get the HTML content
response = session.get(url)
html_content = response.content

# Parse the HTML content with BeautifulSoup
soup = BeautifulSoup(html_content, 'html.parser')
# Find the table containing the problem statistics
table = soup.find('table', {'class': 'sortable'})

new_mismatch=0

timing_file=os.path.join(os.getcwd(),'verilog_problem_set','timing_diagrams_chatgpt_context')
if not os.path.exists(timing_file):
    os.mkdir(timing_file)

results_list=[]
if os.path.exists('HDLBits_chatgpt_feedback_results_context.json'):
    with open('HDLBits_chatgpt_feedback_results_context.json','r') as reader:
        
        for line in reader:
            try:
                # print(text)
                text = json.loads(line)
                results_list.append(text)
            except Exception as e:
                print(e)
    results = pd.DataFrame(results_list)
    columns=['j','problem','problem_file_name','solution_file_name','code','compilation_report','timing diagram','mismatches','total','status','token_length','temperature']
    results.columns=columns

    print(results.head())


for prob_file in prob_files:
    print(prob_file)
    # print(['*****']*10)
       
    
    problem=os.path.basename(prob_file).split('.')[0]
    sol_files = get_solution_files(problem)

    
    for sol_file in sol_files:
        print(sol_file)
        j=1
        if os.path.exists('HDLBits_chatgpt_feedback_results_context.json'):
            if sol_file in results['solution_file_name'].values:
                # if is_modified_yesterday(sol_file) or is_modified_today(sol_file): 
                    print('File exists')
                    continue
            
        eval_path=os.path.join(os.getcwd(),'verilog_problem_set','eval_results_chatgpt',os.path.basename(sol_file).split('.v')[0]+'.txt')
        # print(eval_path)  
        res = open(eval_path,'r').read()
        code_path = os.path.join(os.getcwd(),'verilog_problem_set','result_chatgpt',os.path.basename(sol_file))
        # print(code_path)
        code = open(code_path,'r').read()
        
        # # Parse the HTML code
        compile_msg, status, timing_diagram, new_prompt = get_report(res,eval_path,code,j)
        
        mismatch, total = find_mismatches(compile_msg,status)
        line=search("# Mismatches:",compile_msg)
        print('mismatch: {}, Total samples: {}'.format(mismatch,total))
        
        
        while(('Status: Incorrect' in status or 'Status: Compile Error' in status) and j<5):

                print('iteration',j)
            
                # print(new_prompt)
                

                new_code = generate_code(new_prompt, mismatch, status)
                
                if new_code == None: 
                    print('ChatGPT exception, try again')
                    continue
                    
                
                content = get_eval(session,requests, table,new_code,problem)

                compile_msg, status, timing_diagram, new_prompt = get_report(content,eval_path, new_code,j)

                print('status main',status)
                if status is None:
                    status="Status: Compile Error"
                if (('Status: Incorrect' in status) or ('Status: Success' in status)):
                    # print(compile_msg)

                    new_mismatch,total=find_mismatches(compile_msg,status)
                    mismatch=new_mismatch
                    
                    print('newtmismatch: {}, Total samples: {}'.format(new_mismatch,total))

                
            
                report = {'j':j,'problem':problem,'problem_file_name':prob_file,'solution_file_name':sol_file,
                     'code':new_code,'compilation_report':content,'timing diagram':timing_diagram,'mismatches':new_mismatch,'total':total,'status':status,'token_length':1000,'temperature':0.2}

                print('problem_file_name',os.path.basename(sol_file).split('completed_')[1].rpartition('_')[0]+'.v')
                with open('HDLBits_chatgpt_feedback_results_context.json','a') as f:
                    obj = json.dumps(report)
                    f.write(obj)
                    f.write('\n')
                f.close()

                if('Status: Compile Error' not in status):
                    print('timing file:',os.path.join(timing_file,os.path.basename(sol_file).split('.v')[0]+'_'+str(j)+'_timing_diagram.json'))
                    with open(os.path.join(timing_file,os.path.basename(sol_file).split('.v')[0]+'_'+str(j)+'_timing_diagram.json'),'w') as f:

                        timing_diagram='\n'.join(timing_diagram)
                        obj = json.dumps(timing_diagram)
                        f.write(obj)
                        f.write('\n')
                    f.close()
                

                j=j+1
                
                if 'Status: Success' in status:
        
                    print('Success! Zero new mismatches')
            
       
