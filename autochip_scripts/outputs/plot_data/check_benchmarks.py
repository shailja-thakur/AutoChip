import json
import os

# Load the JSON file
def load_benchmarks(filename):
    with open(filename, 'r') as file:
        data = json.load(file)
    return data

# Get all benchmark directories
def get_benchmark_directories(path):
    return {name for name in os.listdir(path) if os.path.isdir(os.path.join(path, name))}

# Flatten the JSON structure to get all benchmarks
def get_json_benchmarks(json_data):
    benchmarks = set()
    for supercategory, subcategories in json_data.items():
        for subcategory, benchmark_list in subcategories.items():
            benchmarks.update(benchmark_list)
    return benchmarks

# Compare JSON benchmarks with directory benchmarks
def compare_benchmarks(json_file, benchmark_dir):
    # Load data
    json_data = load_benchmarks(json_file)
    json_benchmarks = get_json_benchmarks(json_data)
    dir_benchmarks = get_benchmark_directories(benchmark_dir)

    # Find discrepancies
    missing_directories = json_benchmarks - dir_benchmarks
    extra_directories = dir_benchmarks - json_benchmarks

    # Print results
    if missing_directories:
        print("Benchmarks in JSON but not in directories:")
        for benchmark in missing_directories:
            print(f"  {benchmark}")
    else:
        print("All benchmarks in JSON have corresponding directories.")

    if extra_directories:
        print("Directories not listed in JSON:")
        for directory in extra_directories:
            print(f"  {directory}")
    else:
        print("All directories are listed in JSON.")

# Example usage
json_file = './categories.json'
benchmark_dir = '../../../verilogeval_prompts_tbs/ve_testbenches_human'

compare_benchmarks(json_file, benchmark_dir)

