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

	// Define the 2-bit saturating counters
	reg [1:0] pht [127:0]; // 128-entry table
	reg [6:0] global_history; // 7-bit global branch history register

	integer i;
	
	// Asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			global_history <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				pht[i] <= 2'b01; // Initialize to weakly taken
			end
		end
		else if (train_valid) begin
			if (train_taken) begin
				if (pht[{train_pc ^ train_history}] < 2'b11) begin
					pht[{train_pc ^ train_history}] <= pht[{train_pc ^ train_history}] + 1;
				end
			end
			else begin
				if (pht[{train_pc ^ train_history}] > 2'b00) begin
					pht[{train_pc ^ train_history}] <= pht[{train_pc ^ train_history}] - 1;
				end
			end
			if (train_mispredicted) begin
				global_history <= {train_history[5:0], train_taken};
			end
			else begin
				global_history <= {global_history[5:0], train_taken};
			end
		end
		else if (predict_valid) begin
			predict_history <= global_history;
			case(pht[predict_pc ^ global_history])
				2'b00, 2'b01: predict_taken <= 1'b0;
				2'b10, 2'b11: predict_taken <= 1'b1;
			endcase
			global_history <= {global_history[5:0], predict_taken};
		end
	end

endmodule
