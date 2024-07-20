module top_module(
	input clk,
	input areset, 

	input predict_valid,
	input [6:0] predict_pc,
	output reg predict_taken, 
	output reg [6:0] predict_history,

	input train_valid,
	input train_taken,
	input train_mispredicted,
	input [6:0] train_history, 
	input [6:0] train_pc
);
	// Constants
	parameter TABLE_SIZE = 128;
	parameter GLOBAL_HISTORY_SIZE = 7;
	parameter PC_SIZE = 7;
	
	reg [1:0] pht_table[TABLE_SIZE] = {128{2'b00}}; // Pattern History Table
	reg [6:0] global_history = 7'b0000000; // Global Branch History Register
	
	reg [6:0] pht_index;
	
	always @(predict_pc or global_history) begin
		pht_index = predict_pc ^ global_history;
	end
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			for (integer i = 0; i < TABLE_SIZE; i = i + 1) begin
				pht_table[i] <= 2'b00;
			end
			global_history <= 7'b0000000;
		end else if (predict_valid) begin
			predict_taken <= (pht_table[pht_index] >= 2'b10);
			predict_history <= global_history;
		end else if (train_valid) begin
			integer train_pht_index = train_pc ^ train_history;
			integer train_pht_value = pht_table[train_pht_index];
			integer train_global_history = train_history;
			
			if (train_mispredicted) begin
				pht_table[train_pht_index] <= train_taken ? 2'b00 : 2'b11;
				global_history <= train_global_history;
			end else begin
				pht_table[train_pht_index] <= (train_taken && (train_pht_value < 2'b11)) ? train_pht_value + 1 : (train_taken == 1'b0 && (train_pht_value > 2'b00)) ? train_pht_value - 1 : train_pht_value;
			end
		end
	end
	
endmodule
