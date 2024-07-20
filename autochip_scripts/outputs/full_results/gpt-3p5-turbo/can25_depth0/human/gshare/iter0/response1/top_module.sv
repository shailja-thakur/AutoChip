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

// Define parameters and constants
parameter NUM_ENTRIES = 128; // Number of entries in the pattern history table
parameter COUNTER_SIZE = 2; // Number of bits in each saturating counter

// Define internal signals and registers
reg [6:0] global_history;
reg [6:0] index;
reg [COUNTER_SIZE-1:0] counters[NUM_ENTRIES];

// Prediction stage
always @(posedge clk or posedge areset) begin
	if (areset)
		predict_taken <= 0;
	else if (predict_valid) begin
		index <= predict_pc ^ global_history;
		predict_taken <= (counters[index] == 3) || (counters[index] == 2);
	end
end

// Training stage
always @(posedge clk or posedge areset) begin
	if (areset) begin
		global_history <= 0;
		counters[0] <= 0;
	end else if (train_valid) begin
		index <= train_pc ^ train_history;
		counters[index] <= (train_taken) ? counters[index] + 1 : counters[index] - 1;
		
		if (train_mispredicted) begin
			if (counters[index] == 3)
				counters[index] <= counters[index] - 2;
			else if (counters[index] == 0)
				counters[index] <= counters[index] + 2;
		end
		
		global_history <= {global_history[5:0], train_taken};
	end
end

// Output the current global_history to be observed in prediction interface
assign predict_history = global_history;

endmodule
