module top_module(
	input clk,
	input areset, 

	input [6:0] predict_pc,
	output predict_taken, 
	output [6:0] predict_history,
	output [6:0] index,

	input [6:0] train_pc,
	input train_taken,
	input train_mispredicted,
	input [6:0] train_history, 
	input train_valid
);

	reg [6:0] ghr;
	reg [1:0] pht [127:0]; // pattern history table

	reg [6:0] index_reg;
	reg [1:0] prediction;
	reg predict_valid_reg;
	reg train_valid_reg;

	always @(posedge clk or posedge areset) begin
		if(areset) begin
			ghr <= 0;
			for (int i=0; i<128; i=i+1)
				pht[i] <= 2'b0;
			index_reg <= 0;
			predict_valid_reg <= 0;
			train_valid_reg <= 0;
		end else begin
			index_reg <= {predict_pc[6:0]} ^ {ghr[6:0]};
			if(predict_valid_reg) begin
				predict_taken <= pht[index_reg][1];
				predict_history <= ghr;
			end
			if(train_valid_reg) begin
				if(train_mispredicted) begin
					pht[{train_history[6:0]} ^ {train_pc[6:0]}] <= 2'b0;
					ghr <= train_history;
				end else begin
					pht[index_reg] <= train_taken ? pht[index_reg] == 2'b11 ? 2'b11 : pht[index_reg] + 2'b01 
					: pht[index_reg] == 2'b00 ? 2'b00 : pht[index_reg] - 2'b01;
					ghr <= {ghr[5:0], train_taken};
				end
			end
			predict_valid_reg <= train_valid;
			train_valid_reg <= predict_valid;
		end
	end
	
endmodule
