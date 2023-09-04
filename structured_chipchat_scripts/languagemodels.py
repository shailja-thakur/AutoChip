from abc import ABC, abstractmethod

import openai
from anthropic import Anthropic
from anthropic import AsyncAnthropic, HUMAN_PROMPT, AI_PROMPT

import os
from conversation import Conversation


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


