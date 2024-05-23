import os
from abc import ABC, abstractmethod

## OPENAI
import openai

## ANTHROPIC
from anthropic import Anthropic
from anthropic import AsyncAnthropic, HUMAN_PROMPT, AI_PROMPT

## GEMINI
import google.generativeai as genai

## VERIGEN
from transformers import AutoTokenizer, AutoModelForCausalLM, BitsAndBytesConfig
import torch

## MISTRAL
from mistralai.client import MistralClient
from mistralai.models.chat_completion import ChatMessage

## HUMAN INPUT
import subprocess
import tempfile

## GENERAL AUTOCHIP
from conversation import Conversation


# Abstract Large Language Model
# Defines an interface for using different LLMs so we can easily swap them out
class AbstractLLM(ABC):
    """Abstract Large Language Model."""

    def __init__(self):
        pass

    @abstractmethod
    def generate(self, conversation: Conversation, num_candidates=1):
        """Generate a response based on the given conversation."""
        pass


class ChatGPT(AbstractLLM):
    """ChatGPT Large Language Model."""

    def __init__(self, model_id="gpt-3.5-turbo-16k"):
        super().__init__()
        openai.api_key=os.environ['OPENAI_API_KEY']
        self.client = openai.OpenAI()
        self.model_id = model_id

    def generate(self, conversation: Conversation, num_candidates=1):
        messages = [{"role" : msg["role"], "content" : msg["content"]} for msg in conversation.get_messages()]


        print(f"model_id: {self.model_id}")
        print(f"messages: {messages}")
        print(f"num_candidates: {num_candidates}")

        response = self.client.chat.completions.create(
            model=self.model_id,
            n=num_candidates,
            messages = messages,
        )

        return [c.message.content for c in response.choices]

## TODO: Upgrade to/split off Claude3
class Claude(AbstractLLM):
    """Claude Large Language Model."""

    def __init__(self, model_id="claude-2"):
        super().__init__()
        self.anthropic = Anthropic(
            api_key=os.environ['ANTHROPIC_API_KEY'],
        )
        self.model_id = model_id

    def generate(self,  conversation: Conversation, num_candidates=1):
        messages = conversation.get_messages()
        system = next((item for item in messages if item["role"] == "system"), None)
        messages = [item for item in messages if item["role"] != "system"]

        responses = []
        for n in range(num_candidates):
            completion = self.anthropic.messages.create(
                model=self.model_id,
                messages=messages,
                system=system["content"] if system else "",
                max_tokens=3000,
            )

            responses.append(completion.content[0].text)
        return responses

class Gemini(AbstractLLM):
    """Gemini Large Language Model."""

    def __init__(self, model_id="gemini-pro"):
        super().__init__()
        genai.configure(api_key=os.getenv('GEMINI_API_KEY'))
        self.model = genai.GenerativeModel(model_id)

    def generate(self, conversation: Conversation, num_candidates=1):
        conv_messages = conversation.get_messages()

        messages = [{"role" : msg["role"], "parts" : [msg["content"]]} for msg in conv_messages]

        # Gemini functions don't allow two consecutive user messages, and has no system message, so we need to merge a system message with a user message if one is available. This *should* only happen with the initial prompt.
        for i in range(len(messages)):
            if i >= len(messages) - 1:
                break
            elif messages[i]["role"] == "system":
                if messages[i+1]["role"] == "user":
                    messages[i+1]["parts"].insert(0, messages[i]["parts"][0])
                    del messages[i]
                else:
                    messages[i]["role"] = "user"
            elif messages[i]["role"] == "assistant":
                messages[i]["role"] = "model"

        if messages[-1]["role"] == "system":
            messages[-1]["role"] = "user"


        #responses = self.model.generate_content(messages, generation_config=genai.GenerationConfig(candidate_count=num_candidates)) ## USE ONCE MULTIPLE CANDIDATES IS SUPPORTED
        responses = []
        for n in range(num_candidates):
            responses.append(self.model.generate_content(messages).candidates[0].content.parts[0].text)
        return responses
        #return [c.content.parts[0].text for c in response.candidates]


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

    def generate(self, conversation: Conversation, num_candidates=1):

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

class Mistral(AbstractLLM):
    """Mistral Large Language Model."""

    def __init__(self, model_id="open-mixtral-8x22b"):
        super().__init__()
        self.client = MistralClient(api_key=os.environ['MISTRAL_API_KEY'])
        self.model_id = model_id

    def generate(self, conversation: Conversation, num_candidates=1):
        messages = []
        for msg in conversation.get_messages():
            messages.append(ChatMessage(
                role=msg["role"],
                content=msg["content"],
            ))

        responses = []
        for n in range(num_candidates):
            response = self.client.chat(
                model=self.model_id,
                messages=messages,
            )
            responses.append(response.choices[0].message.content)

        return responses

class HumanInput(AbstractLLM):
    """Human Input Large Language Model."""

    def __init__(self):
        super().__init__()

    def get_text_from_editor(self, initial_text="", editor=None):
        editor = editor or os.getenv('EDITOR') or 'nano' # Use configured editor, or an environment variable, or nano as a fallback
        with tempfile.NamedTemporaryFile(suffix=".v") as tf:
            tf.write(initial_text.encode())
            tf.flush()
            subprocess.run([editor, tf.name])
            tf.seek(0)
            return tf.read().decode()

    def generate(self, conversation: Conversation, num_candidates=1):
        print(conversation.get_messages())
        return self.get_text_from_editor(initial_text=conversation.get_messages()[-1]['content'])
