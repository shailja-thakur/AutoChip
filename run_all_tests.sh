#!/bin/bash

prompt_dir=`pwd`/prompt_feedback_testing
testbench_dir=`pwd`/hdlbits_testbenches
output_dir=`pwd`/outputs

autogen_script=`pwd`/structured_chipchat_scripts/auto_create_verilog.py

source `pwd`/structured_chipchat_scripts/venv/bin/activate

tests_per_prompt=5

promtps=()

for path in "$prompt_dir"/*; do
	if [[ -f "$path" ]]; then
		prompt_name=$(basename "$path")
		prompts+=("${prompt_name%.*}")
	fi
done

for prompt in "${prompts[@]}"; do
	#check if there's a matching testbench
	testbench="${testbench_dir}/${prompt}_0_tb.v"
	if [[ ! -f $testbench ]]; then
		echo "No matching testbench for ${prompt}"
		continue
	fi

	for ((i=0; i<tests_per_prompt; i++)); do
		mkdir -p $output_dir/$prompt/test_${i}
		cd $output_dir/$prompt/test_${i}

		python3 $autogen_script --prompt="$(cat $prompt_dir/${prompt}.v)" --testbench=$testbench --name=top_module --iter=10 --model=ChatGPT3p5 --log=${prompt}_log.txt
		cd -
	done
done
