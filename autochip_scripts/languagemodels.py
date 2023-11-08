from abc import ABC, abstractmethod

import openai

from anthropic import Anthropic
from anthropic import AsyncAnthropic, HUMAN_PROMPT, AI_PROMPT

import google.generativeai as palm

import os
from conversation import Conversation

from transformers import AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig
import torch


# Abstract Large Language Model
# Defines an interface for using different LLMs so we can easily swap them out
class AbstractLLM(ABC):
    """Abstract Large Language Model."""

    def __init__(self):
        pass

    @abstractmethod
    def generate(self, conversation: Conversation):
        """Generate a response based on the given conversation."""
        pass


class ChatGPT3p5(AbstractLLM):
    """ChatGPT Large Language Model."""

    def __init__(self):
        super().__init__()
        openai.api_key=os.environ['OPENAI_API_KEY']

    def generate(self, conversation: Conversation):
        messages = [{'role' : msg['role'], 'content' : msg['content']} for msg in conversation.get_messages()]

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo-16k",
            messages = messages,
        )

        return response['choices'][0]['message']['content']

class ChatGPT4(AbstractLLM):
    """ChatGPT Large Language Model."""

    def __init__(self):
        super().__init__()
        openai.api_key=os.environ['OPENAI_API_KEY']

    def generate(self, conversation: Conversation):
        messages = [{'role' : msg['role'], 'content' : msg['content']} for msg in conversation.get_messages()]

        response = openai.ChatCompletion.create(
            model="gpt-4",
            messages = messages,
        )

        return response['choices'][0]['message']['content']

class Claude(AbstractLLM):
    """Claude Large Language Model."""

    def __init__(self):
        super().__init__()
        self.anthropic = Anthropic(
            api_key=os.environ['ANTHROPIC_API_KEY'],
        )

    def generate(self, conversation: Conversation):
        prompt = ""
        for message in conversation.get_messages():
            if message['role'] == 'system' or message['role'] == 'user':
                prompt += f"\n\nHuman: {message['content']}"
            elif message['role'] == 'assistant':
                prompt += f"\n\nAssistant: {message['content']}"
        prompt += "\n\nAssistant:"


        completion = self.anthropic.completions.create(
            model="claude-2",
            max_tokens_to_sample=3000,
            prompt=prompt,
        )

        #print(prompt)
        #print(completion.completion)
        return completion.completion

class PaLM(AbstractLLM):
    """PaLM Large Language Model."""

    def __init__(self):
        super().__init__()
        palm.configure(api_key=os.environ['PALM_API_KEY'])

    def generate(self, conversation: Conversation):

        context = None
        messages = []
        reply = ''

        for message in conversation.get_messages():
            if message['role'] == 'system':
                context = message['content']
            else:
                if message['role'] == 'user':
                    messages.append({'author': '0', 'content': message['content']})
                elif message['role'] == 'assistant':
                    messages.append({'author': '1', 'content': message['content']})

        response = palm.chat(context=context, messages=messages)
        #print(response)
        return response.last


class CodeLlama(AbstractLLM):
    """CodeLlama Large Language Model."""

    def __init__(self, model_id="codellama/CodeLlama-13b-hf"):
        super().__init__()

        self.model_id = model_id

        self.tokenizer = CodeLlamaTokenizer.from_pretrained("codellama/CodeLlama-34b-Instruct-hf")
        self.model = LlamaForCausalLM.from_pretrained("codellama/CodeLlama-34b-Instruct-hf", device_map="auto",torch_dtype = "auto")

    def _format_prompt(self, conversation: Conversation) -> str:
        # Extract the system prompt, initial user prompt, and the most recent user prompt and answer.
        messages = conversation.get_messages()

        prompt = ""


        user_message=""
        systemp_prompt = ""
        answer_message=""

        for message in messages:
            # Append system messages with the "<<SYS>>" tags
            if message['role'] == 'system':
                #system_prompt = message['content']
                prompt += f"<<SYS>>\n{message['content']}\n<</SYS>>\n\n"
            # Append user messages with the "Human" prefix
            elif message['role'] == 'user':
                user_message = message['content']
                prompt += f"<s>[INST] {user_message.strip()} [/INST] "
            # Append assistant messages with the "Assistant" prefix wrapped with [INST] tags
            elif message['role'] == 'assistant':
                prompt += f"{message['content']}"
                #answer_message = message['content']

            #context = f"<<SYS>>\n{system_prompt}\n<</SYS>>\n\n{user_message}"
            #prompt += f"<s>[INST] {context} [/INST] {answer_message}"

        print(prompt)


        return prompt

    def _format_prompt_donotuse(self, conversation: Conversation) -> str:
        # Extract the system prompt, initial user prompt, and the most recent user prompt and answer.
        messages = conversation.get_messages()

        # Extract the initial system message
        system_prompt = [msg['content'] for msg in messages if msg['role'] == 'system'][0]

        # Extract the user and assistant messages
        user_messages = [msg['content'] for msg in messages if msg['role'] == 'user']
        assistant_messages = [msg['content'] for msg in messages if msg['role'] == 'assistant']

        # If there are multiple user messages, only take the last one for the prompt
        most_recent_user_prompt = user_messages[-1]

        # If there are assistant messages, consider the last assistant message as the answer
        # to the most recent user message
        if assistant_messages:
            most_recent_answer = assistant_messages[-1]
            prompt = f"<<SYS>>\n{system_prompt}\n<</SYS>>\n\n{most_recent_user_prompt.strip()}"
            prompt += f"<s>[INST] {most_recent_answer.strip()} [/INST]"
        else:
            prompt = f"<<SYS>>\n{system_prompt}\n<</SYS>>\n\n{most_recent_user_prompt.strip()}"

        return prompt

    def generate(self, conversation: Conversation):

        # Prepare the prompt using the method we created
        prompt = self._format_prompt(conversation)

        inputs = self.tokenizer(prompt, return_tensors="pt").to("cuda")

        output = self.model.generate(
            inputs["input_ids"],
            max_new_tokens=3000,
            do_sample=True,
            top_p=0.9,
            temperature=0.1,
        )

        # Move the output tensor to the CPU
        output = output[0].to("cpu")
        # Decode the output to get the generated text
        decoded_output = self.tokenizer.decode(output)
        
        # Extract only the generated response
        response = decoded_output.split("[/INST]")[-1].strip()

        #response = find_verilog_modules(decoded_output)[-1]

        print('RESPONSE START')
        print('\n'.join(find_verilog_modules(response)))
        print('RESPONSE END')
        return response