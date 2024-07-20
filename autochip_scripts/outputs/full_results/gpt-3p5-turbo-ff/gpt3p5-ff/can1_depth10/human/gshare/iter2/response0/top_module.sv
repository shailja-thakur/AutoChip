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
	
	reg [1:0] pht_table[TABLE_SIZE]; // Pattern History Table
	reg [6:0] global_history; // Global Branch History Register
	
	// Fetch stage
	wire [6:0] pht_index;
	assign pht_index = predict_pc ^ global_history;
	assign predict_taken = (pht_table[pht_index] >= 2);
	assign predict_history = global_history;
	
	// Update stage
	reg [6:0] train_pht_index;
	reg [1:0] train_pht_value;
	reg [6:0] train_global_history;
	
	integer i;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			for (i = 0; i < TABLE_SIZE; i = i + 1) begin
				pht_table[i] <= 0;
			end
			global_history <= 0;
		end else begin
			train_pht_index <= train_pc ^ train_history;
			train_pht_value <= pht_table[train_pht_index];
			train_global_history <= train_history;
			
			if (train_valid) begin
				if (train_mispredicted) begin
					pht_table[train_pht_index] <= train_taken ? 0 : 3;
					global_history <= train_global_history;
				end else begin
					pht_table[train_pht_index] <= (train_taken && (train_pht_value < 3)) ? train_pht_value + 1 : (train_taken == 0 && (train_pht_value > 0)) ? train_pht_value - 1 : train_pht_value;
				end
			end
		end
	end
	
endmodule
