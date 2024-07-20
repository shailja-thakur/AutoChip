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

	reg [6:0] index;
	reg [1:0] pht [127:0]; // pattern history table

	reg [6:0] ghr;
	reg [1:0] prediction;
	
	always @(posedge clk or posedge areset) begin
		if(areset)
			ghr <= 0;
		else if(predict_valid) begin
			ghr <= {ghr[5:0], prediction[0]};
			index <= {predict_pc[6:0]} ^ {ghr[6:0]};
			prediction <= pht[index];
		end else begin
			ghr <= train_history;
			index <= {train_pc[6:0]} ^ {ghr[6:0]};
			if(train_valid && train_mispredicted) begin
				pht[index] <= 2'b00;
			end else begin
				ghr <= {ghr[5:0], train_taken};
				pht[index] <= train_taken ? 
					(pht[index] == 2'b11 ? 2'b11 : pht[index] + 2'b01) 
					: (pht[index] == 2'b00 ? 2'b00 : pht[index] - 2'b01);
			end
		end
	end
	
	assign predict_taken = prediction[1];
	assign predict_history = ghr;
	
endmodule
