import os

# Conversation class
# allows us to abstract away the details of the conversation for use with different LLM APIs
class Conversation:
    def __init__(self, log_file=None):
        self.messages = []
        self.log_file = log_file

        if self.log_file and os.path.exists(self.log_file):
            open(self.log_file, 'w').close()

    def add_message(self, role, content):
        """Add a new message to the conversation."""
        self.messages.append({'role': role, 'content': content})

        if self.log_file:
            with open(self.log_file, 'a') as file:
                file.write(f"{role}: {content}\n")

    def get_messages(self):
        """Retrieve the entire conversation."""
        return self.messages

    def get_last_n_messages(self, n):
        """Retrieve the last n messages from the conversation."""
        return self.messages[-n:]

    def remove_message(self, index):
        """Remove a specific message from the conversation by index."""
        if index < len(self.messages):
            del self.messages[index]

    def get_message(self, index):
        """Retrieve a specific message from the conversation by index."""
        return self.messages[index] if index < len(self.messages) else None

    def clear_messages(self):
        """Clear all messages from the conversation."""
        self.messages = []

    def __str__(self):
        """Return the conversation in a string format."""
        return "\n".join([f"{msg['role']}: {msg['content']}" for msg in self.messages])
