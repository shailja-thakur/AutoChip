from abc import ABC, abstractmethod
import openai
import os
from conversation import Conversation

openai.api_key=os.env('OPENAI_API_KEY')

# Abstract Large Language Model
# Defines an interface for using different LLMs so we can easily swap them out
class AbstractLLM(ABC):
    """Abstract Large Language Model."""

    @staticmethod
    @abstractmethod
    def generate(conversation: Conversation):
        """Generate a response based on the given conversation."""
        pass


class ChatGPT3p5(AbstractLLM):
    """ChatGPT Large Language Model."""

    @staticmethod
    def generate(conversation: Conversation):
        messages = [{'role' : msg['role'], 'content' : msg['content']} for msg in conversation.get_messages()]

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo-16k",
            messages = messages,
        )

        return response['choices'][0]['message']['content']

class ChatGPT4(AbstractLLM):
    """ChatGPT Large Language Model."""

    @staticmethod
    def generate(conversation: Conversation):
        messages = [{'role' : msg['role'], 'content' : msg['content']} for msg in conversation.get_messages()]

        response = openai.ChatCompletion.create(
            model="gpt-4",
            messages = messages,
        )

        return response['choices'][0]['message']['content']

class SomeOtherLLM(AbstractLLM):
    """Some Other Large Language Model."""

    @staticmethod
    def generate(conversation: Conversation):
        # call to the other LLM API goes here
        pass

