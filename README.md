# AutoChip

AutoChip is designed to generate functional Verilog modules from an initial design prompt and testbench using a selected large language model. Errors from compilation and simulation are fed back into the LLM for repair.

## Setup

### Prerequisites

- Python 3.6 or newer
- `pip` for installing dependencies
- [Icarus Verilog](https://github.com/steveicarus/iverilog)

### Installation

1.  Clone the repository to your local machine:
```sh
git clone https://github.com/shailja-thakur/AutoChip.git
cd AutoChip
```
2.  Set up a virtual environment (optional but recommended):
```sh
python3 -m venv venv
source venv/bin/activate
```
3.  Install the required python packages:
```sh
pip3 install -r requirements.txt
```

### Environment Variables
API Keys (Must be set for the models being used):
 - OpenAI API Key: `OPENAI_API_KEY`
 - Anthropic API Key: `ANTHROPIC_API_KEY`

## Configuration
AutoChip can be used with with a JSON config file or with a set of command line arguments.

### General Settings
These are the ordinary settings you can use for AutoChip. Each of these settings can be set in a JSON file or with command line arguments (defined below or in `usage.txt`).

An exmaple general section of `config.json`:
```json
"general": {
    "prompt": "../verilogeval_prompts_tbs/ve_testbenches_human/rule110/rule110.sv",
    "name": "top_module",
    "testbench": "../verilogeval_prompts_tbs/ve_testbenches_human/rule110/rule110_tb.sv",
    "model_family": "ChatGPT",
    "model_id": "gpt-4o-mini",
    "num_candidates": 2,
    "iterations": 3,
    "outdir": "test_outdir",
    "log": "log.txt",
    "mixed-models": true
},
```
The command line arguments are defined in `usage.txt` as follows:
```
Usage: generate_verilog.py [options]

Required Options:

    -p, --prompt=<prompt>           : File containing the design prompt

    -n, --name=<module name>        : The module name, must match the testbench expected module name

    -t, --testbench=<testbench file>: File containing the testbench

    -o, --outdir=<output directory> : Directory to place all run-specific files in

    -l, --log=<log file>            : Log the output of the model to the given file

    -f, --model-family=<family>     : The LLM family to use (required unless using mixed model config)
                                      Must be one of the following:
                                      - ChatGPT
                                      - Claude
                                      - Mistral
                                      - Gemini
                                      - CodeLlama
                                      - Human (requests user input)

    -m, --model-id=<model ID>       : The specific model to use for the model family (required unless using mixed model config)

Optional Options:

    -h, --help                      : Prints this usage message

    -c, --config=<config file>      : Specify the configuration file (default: config.json)

    -i, --iter=<iterations>         : Number of iterations before the tool quits (default: 10)

    -k, --num-candidates=<number>   : The number of candidates to rank per tree level (default: 1)
```

### Mixed-Models
AutoChip supports calling to different models at certain points of the tree search. This can only be configured with the config file, there are no command line arguments to define mixed-model operation.

An example mixed-model section of `config.json`:
```json
"mixed-models": {
    "model1": {
        "start_iteration": 0,
        "model_family": "ChatGPT",
        "model_id": "gpt-4o-mini"
    },
    "model2": {
        "start_iteration": -1,
        "model_family": "ChatGPT",
        "model_id": "gpt-4o"
    }
}
```

## Usage
To use the tool, follow the steps below:

1. Prepare your initial Verilog design prompt and a testbench file that matches your module's requirements.

2. Set up a `config.json` file as described above, or call `generate_verilog.py` with command line arguments defined in `usage.txt`


## Citation

If you find our work helpful, please cite as
```

@misc{thakur2024autochipautomatinghdlgeneration,
      title={AutoChip: Automating HDL Generation Using LLM Feedback}, 
      author={Shailja Thakur and Jason Blocklove and Hammond Pearce and Benjamin Tan and Siddharth Garg and Ramesh Karri},
      year={2024},
      eprint={2311.04887},
      archivePrefix={arXiv},
      primaryClass={cs.PL},
      url={https://arxiv.org/abs/2311.04887}, 
}

```

## LICENCE

Please note that this repo is under [Apache License](LICENSE)


## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=shailja-thakur/AutoChip&type=Date)](https://star-history.com/#shailja-thakur/AutoChip&Date)
