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

// Declare internal signals and registers
wire [6:0] predict_index;
reg [6:0] global_history;
reg [1:0] pht[0:127];
reg predict_taken;
reg [6:0] predict_history;

// Predictor logic
assign predict_index = predict_pc ^ global_history;
assign predict_taken = pht[predict_index][1];

// Training logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		global_history <= 0;
		for (int i = 0; i < 128; i++) begin
			pht[i] <= 0;
		end
	end else begin
		if (train_valid) begin
			pht[train_pc ^ train_history][1] <= train_taken;
			if (train_mispredicted) begin
				global_history <= train_history;
			end
		end
	end
end

// Output registers
always @(posedge clk or posedge areset) begin
	if (areset) begin
		predict_history <= 0;
	end else begin
		if (predict_valid) begin
			predict_history <= global_history;
		end
	end
end

endmodule
