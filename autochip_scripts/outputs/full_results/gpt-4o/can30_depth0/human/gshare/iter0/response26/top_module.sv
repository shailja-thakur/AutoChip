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

	reg [1:0] PHT [0:127];
	reg [6:0] global_history;

	integer i;

	// Asynchronous reset
	always @(posedge areset or posedge clk) begin
		if (areset) begin
			global_history <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // weakly not taken
			end
		end else if (clk) begin
			if (train_valid) begin
				if (train_taken) begin
					if (PHT[{train_pc ^ train_history}] < 2'b11) begin
						PHT[{train_pc ^ train_history}] <= PHT[{train_pc ^ train_history}] + 1;
					end
				end else if (!train_taken) begin
					if (PHT[{train_pc ^ train_history}] > 2'b00) begin
						PHT[{train_pc ^ train_history}] <= PHT[{train_pc ^ train_history}] - 1;
					end
				end
				if (train_mispredicted) begin
					global_history <= {global_history[5:0], train_taken};
				end
			end else if (predict_valid) begin
				predict_taken <= (PHT[{predict_pc ^ global_history}] >= 2'b10);
				global_history <= {global_history[5:0], predict_taken};
				predict_history <= global_history;
			end
		end
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			predict_taken <= 0;
			predict_history <= 7'b0;
		end
	end

endmodule
