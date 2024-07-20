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

reg [6:0] history_reg;

// Hash function (XOR)
wire [6:0] hashed_index = predict_pc ^ history_reg;

// Pattern History Table (PHT)
reg [1:0] pht [0:127];

// Prediction logic
assign predict_taken = pht[hashed_index] > 1;
assign predict_history = history_reg;

// Training logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		history_reg <= 0;
	end else begin
		if (train_valid) begin
			pht[train_pc] <= (train_taken && !train_mispredicted) ? pht[train_pc] + 1 : (train_taken || train_mispredicted) ? pht[train_pc] - 1 : pht[train_pc];
		end
		if (predict_valid) begin
			history_reg <= {history_reg[5:0], predict_taken};
		end
	end
end

endmodule
