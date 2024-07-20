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
	
	reg [6:0] branch_history_reg;
	reg [6:0] pht_index;
	reg [1:0] prediction_result;

	reg [1:0] pattern_history_table [0:127];
	
	initial begin
		branch_history_reg <= 0;
		pht_index <= 0;
		prediction_result <= 0;
	end
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			branch_history_reg <= 0;
		else if (predict_valid) begin
			branch_history_reg <= {branch_history_reg[5:0], predict_taken};
			pht_index <= {predict_pc, branch_history_reg} ^ 7'b1111111;
			prediction_result <= pattern_history_table[pht_index];
		end else if (train_valid) begin
			branch_history_reg <= {branch_history_reg[5:0], train_taken};
			pht_index <= {train_pc, train_history} ^ 7'b1111111;
			if (train_mispredicted) begin
				pattern_history_table[pht_index] <= 2'b00;
				branch_history_reg <= train_history;
			end else begin
				pattern_history_table[pht_index] <= {prediction_result, train_taken};
			end
		end
	end
	
	assign predict_taken = prediction_result[1];
	assign predict_history = branch_history_reg;
	
endmodule
