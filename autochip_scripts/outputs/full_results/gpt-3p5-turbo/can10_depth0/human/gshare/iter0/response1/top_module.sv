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

reg [6:0] history [0:127];
reg [1:0] counter [0:127];
reg [6:0] pc_reg;

assign predict_taken = (counter[pc_reg] == 3 || counter[pc_reg] == 2);
assign predict_history = history[pc_reg];

always @(posedge clk or posedge areset) begin
	if (areset)
		pc_reg <= 0;
	else if (predict_valid)
		pc_reg <= predict_pc;    
	else if (train_valid)
		pc_reg <= train_pc; 
end

always @(posedge clk or posedge areset) begin
	if (areset) begin
		for (int i = 0; i < 128; i = i + 1) begin
			counter[i] <= 0;
			history[i] <= 0;
		end
	end else if (train_valid) begin
		history[train_pc] <= train_history;
		if (train_mispredicted) begin
			for (int i = 0; i < 128; i = i + 1) begin
				if (history[i] == train_history)
					counter[i] <= 0;
			end
		end
		if (train_taken)
			counter[train_pc] <= counter[train_pc] < 3 ? counter[train_pc] + 1 : 3;
		else
			counter[train_pc] <= counter[train_pc] > 0 ? counter[train_pc] - 1 : 0;
	end else if (predict_valid)
		counter[pc_reg] <= counter[pc_reg] < 3 ? counter[pc_reg] + 1 : 3;
end
endmodule
