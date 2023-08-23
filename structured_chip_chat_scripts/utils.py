import sys

# Allows us to log the output of the model to a file if logging is enabled
class LogStdoutToFile:
    def __init__(self, filename):
        self._filename = filename
        self._original_stdout = sys.stdout

    def __enter__(self):
        if self._filename:
            sys.stdout = open(self._filename, 'w')
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        if self._filename:
            sys.stdout.close()
        sys.stdout = self._original_stdout

