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

// 7-bit global branch history register
reg [6:0] global_history;

// 128-entry pattern history table (PHT)
reg [1:0] pht [127:0];

// Hash function to generate PHT index from PC and global history
function [6:0] hash_function;
	input [6:0] pc;
	input [6:0] history;
	begin
		hash_function = pc ^ history;
	end
endfunction

always @(posedge clk or posedge areset) begin
	if (areset) begin
		global_history <= 7'b0;
		for (int i = 0; i < 128; i = i + 1) begin
			pht[i] <= 2'b10; // initialize PHT to weakly taken
		end
	end
	else begin
		// Prediction logic
		if (predict_valid) begin
			// Hash PC and global history to get PHT index
			reg [6:0] pht_index = hash_function(predict_pc, global_history);
			
			// Make prediction based on PHT state
			predict_taken <= (pht[pht_index] >= 2'b10);
			predict_history <= global_history;
		end

		// Training logic
		if (train_valid) begin
			// Hash PC and global history to get PHT index
			reg [6:0] pht_index = hash_function(train_pc, train_history);
			
			// Update PHT based on actual branch outcome
			if (train_taken) begin
				if (pht[pht_index] != 2'b11) begin
					pht[pht_index] <= pht[pht_index] + 1'b1;
				end
			end
			else begin
				if (pht[pht_index] != 2'b00) begin
					pht[pht_index] <= pht[pht_index] - 1'b1;
				end
			end

			// Update global history register
			if (train_mispredicted) begin
				global_history <= train_history;
			end
			else begin
				global_history <= (global_history << 1) | train_taken;
			end
		end
	end
end

endmodule
