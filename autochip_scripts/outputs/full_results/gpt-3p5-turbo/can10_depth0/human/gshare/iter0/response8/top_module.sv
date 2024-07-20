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

// Define parameters
parameter TABLE_SIZE = 128;
parameter INDEX_SIZE = 7;
parameter PC_SIZE = 7;
parameter HISTORY_SIZE = 7;

// Define states
enum logic [1:0] {
	STRONG_NOT_TAKEN,
	WEAK_NOT_TAKEN,
	WEAK_TAKEN,
	STRONG_TAKEN
} saturating_counters [0:TABLE_SIZE-1];

// Define registers
reg [6:0] global_history_register;
reg predict_taken;
reg [6:0] predict_history;

// Define hash function
function [6:0] compute_index;
	input [6:0] pc;
	input [6:0] history;
	begin
		compute_index = pc ^ history;
	end
endfunction

// Define predictor logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		global_history_register <= 0;
		for (int i = 0; i < TABLE_SIZE; i++) begin
			saturating_counters[i] <= STRONG_NOT_TAKEN;
		end
	end
	else begin
		global_history_register <= {global_history_register[5:0], predict_taken};
		
		if (predict_valid) begin
			predict_history <= global_history_register;
			predict_taken <= (saturating_counters[compute_index(predict_pc, predict_history)] >= 2);
		end
		
		if (train_valid) begin
			saturating_counters[compute_index(train_pc, train_history)] <=
				(train_taken && !train_mispredicted && saturating_counters[compute_index(train_pc, train_history)] < STRONG_TAKEN) ? 
					saturating_counters[compute_index(train_pc, train_history)]+1 :
					(!train_taken && train_mispredicted && saturating_counters[compute_index(train_pc, train_history)] > STRONG_NOT_TAKEN) ? 
						saturating_counters[compute_index(train_pc, train_history)]-1 :
						saturating_counters[compute_index(train_pc, train_history)];
		end
	end
end

endmodule
