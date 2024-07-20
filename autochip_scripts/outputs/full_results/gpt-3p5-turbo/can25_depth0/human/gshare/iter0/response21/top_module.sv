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
	
	reg [6:0] pht_index;
	reg [1:0] pht_entry;
	reg [6:0] bhr;
	reg [1:0] pht [0:127];

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			pht_index <= 0;
			pht_entry <= 0;
			bhr <= 0;
		end else if (train_valid) begin
			pht_index <= train_pc ^ bhr[6:0];
			pht_entry <= pht[pht_index];
		end else if (predict_valid) begin
			pht_index <= predict_pc ^ bhr[6:0];
			pht_entry <= pht[pht_index];
		end
		
		if (predict_valid || train_valid) begin
			predict_taken <= pht_entry[1];
			predict_history <= bhr;
		end else begin
			predict_taken <= 0;
			predict_history <= 0;
		end
		
		if (train_valid) begin
			if (train_mispredicted) begin
				pht[pht_index] <= pht_entry - 1;
				bhr[6:0] <= train_history;
			end else begin
				pht[pht_index] <= pht_entry + 1;
				bhr[6:0] <= {bhr[5:0], train_taken};
			end
		end
	end
	
endmodule
