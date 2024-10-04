#!/bin/bash

verilog_eval_dir=`pwd`/../verilogeval_prompts_tbs/rerun_haiku_machine

output_dir=./outputs/reruns/claude-3-haiku-20240307_RERUNS/machine

autogen_script=`pwd`/auto_create_verilog.py

source `pwd`/../venv/bin/activate

candidates=(5)
#candidates=(1 3 5 10)
depth=(10)
#depth=(0 1 3 5 10)
#k=(1 3 5)

promtps=()

for path in "$verilog_eval_dir"/*; do
	if [[ -d "$path" ]]; then
		prompt_name=$(basename "$path")
		prompts+=("${prompt_name%.*}")
	fi
done

for prompt in "${prompts[@]}"; do
	#test_set_dir=$output_dir/candidates${c}_depth${d}
	mkdir -p $output_dir/$prompt

	python3 auto_create_verilog.py --prompt="$(cat $verilog_eval_dir/${prompt}/${prompt}.sv)" -n top_module -t $verilog_eval_dir/${prompt}/${prompt}_tb.sv -i 10 -m Claude --model-id=claude-3-haiku-20240307 -o $output_dir/$prompt --log=log.txt --num-candidates=5
	#echo "Prompt: $prompt, Candidates: $c, Depth: $d"
done
