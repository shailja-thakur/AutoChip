module top_module(
	input clk,
	input areset, 

	input predict_valid,
	input [6:0] predict_pc,
	output predict_taken, 
	output [6:0] predict_history,

	input train_valid,
	input train_taken,
	input train_mispredicted,
	input [6:0] train_history, 
	input [6:0] train_pc
);

	reg [1:0] pattern_history_table [0:127]; // 128-entry 2-bit saturating counters
	reg [6:0] global_history_register;
	reg [6:0] index;
	reg [1:0] predicted_state;
	reg [6:0] predicted_history;

	always @(posedge clk or posedge areset) begin
		if (areset)
			global_history_register <= 0;
		else if (train_valid)
			global_history_register <= train_history;
		else if (predict_valid)
			global_history_register <= predict_history;
	end

	always @(posedge clk) begin
		if (areset) begin
			predict_taken <= 0;
			predict_history <= 0;
		end
		else if (predict_valid) begin
			index <= predict_pc ^ global_history_register;
			predict_taken <= (pattern_history_table[index] >= 2);
			predict_history <= global_history_register;
		end
		else if (train_valid) begin
			index <= train_pc ^ train_history;
			predicted_state <= pattern_history_table[index];
			predicted_history <= train_history;
		end
	end

	always @(posedge clk) begin
		if (areset) begin
			pattern_history_table <= 0;
		end
		else if (train_valid) begin
			if (train_mispredicted)
				pattern_history_table[index] <= (predicted_state == 3) ? predicted_state - 2 : predicted_state + 1;
			else
				pattern_history_table[index] <= (predicted_state == 0) ? predicted_state + 2 : predicted_state - 1;
		end
	end

endmodule
