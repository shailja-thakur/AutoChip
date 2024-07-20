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
	
	reg [1:0] pattern_history_table [127:0];
	reg [6:0] global_history_register;
	
	// Initialization and Reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			integer i;
			for (i = 0; i < 128; i = i + 1) begin
				pattern_history_table[i] <= 2'b10; // Weakly taken state
			end
			global_history_register <= 7'b0;
		end
	end

	// Predict Branch
	always @(*) begin
		if (predict_valid) begin
			predict_history = global_history_register;
			predict_taken = pattern_history_table[predict_pc ^ global_history_register][1];
		end
	end
	
	// Train Branch Predictor
	always @(posedge clk) begin
		if (train_valid) begin
			integer index;
			index = train_pc ^ train_history;
			if (train_taken) begin
				if (pattern_history_table[index] != 2'b11) begin
					pattern_history_table[index] <= pattern_history_table[index] + 1;
				end
			end else begin
				if (pattern_history_table[index] != 2'b00) begin
					pattern_history_table[index] <= pattern_history_table[index] - 1;
				end
			end
			
			if (train_mispredicted) begin
				global_history_register <= {train_history[6:1], train_taken};
			end else begin
				global_history_register <= {global_history_register[6:1], train_taken};
			end
		end else if (predict_valid) begin
			global_history_register <= {global_history_register[6:1], predict_taken};
		end
	end

endmodule
