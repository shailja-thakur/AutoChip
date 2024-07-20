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

	reg [6:0] ghr;
	reg [1:0] pht [127:0]; // pattern history table

	always @(posedge clk or posedge areset) begin
		if(areset) begin
			ghr <= 0;
			for (int i=0; i<128; i=i+1)
				pht[i] <= 0;
		end else begin
			if(predict_valid) begin
				predict_taken <= pht[ghr ^ predict_pc][1];
				predict_history <= ghr;
			end
			
			if(train_valid) begin
				if(train_mispredicted) begin
					pht[ghr ^ train_pc] <= train_taken ? 2'b01 : 2'b00;
					ghr <= train_history;
				end else begin
					pht[ghr ^ train_pc] <= train_taken ? 
						(pht[ghr ^ train_pc] == 2'b11 ? 2'b11 : pht[ghr ^ train_pc] + 2'b01) 
						: (pht[ghr ^ train_pc] == 2'b00 ? 2'b00 : pht[ghr ^ train_pc] - 2'b01);
					ghr <= {ghr[5:0], train_taken};
				end
			end
		end
	end
	
endmodule
