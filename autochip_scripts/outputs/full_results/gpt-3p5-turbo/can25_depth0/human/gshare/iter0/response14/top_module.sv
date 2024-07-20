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

	reg [6:0] index;
	reg [1:0] counter [0:127];

	// Prediction interface
	always @(posedge clk) begin
		if (areset) begin
			predict_taken <= 1'b0;
			predict_history <= 7'd0;
		end else if (predict_valid) begin
			index <= predict_pc ^ predict_history;
			predict_taken <= (counter[index] == 2'd3) ? 1'b1 : 1'b0;
			predict_history <= {predict_history[5:0], predict_taken};
		end
	end

	// Training interface
	always @(posedge clk) begin
		if (areset) begin
			for (integer i = 0; i < 128; i = i + 1) begin
				counter[i] <= 2'd2;
			end
		end else if (train_valid) begin
			index <= train_pc ^ train_history;
			if (train_mispredicted) begin
				for (integer i = 0; i < 128; i = i + 1) begin
					counter[i] <= 2'd2;
				end
				counter[index] <= (train_taken) ? 2'd1 : 2'd0;
				predict_history <= train_history;
			end else begin
				counter[index] <= (train_taken) ? 2'd3 : 2'd2;
				predict_history <= {train_history[5:0], train_taken};
			end
		end
	end

endmodule
