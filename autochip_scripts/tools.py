from abc import ABC, abstractmethod
import sys

class AbstractCompilationTool(ABC):
    """Abstract Compilation Tool."""

    def __init__(self):
        pass

    @abstractmethod
    def compile(self, file: str):
        """Compile the given file."""
        pass

class

