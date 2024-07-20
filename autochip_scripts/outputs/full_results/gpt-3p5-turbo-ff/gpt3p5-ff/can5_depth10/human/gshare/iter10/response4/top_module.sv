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
	reg [6:0] train_pc_reg;
	reg train_taken_reg;
	
	// Prediction interface
	always @(posedge clk or posedge areset) begin
		if(areset) begin
			ghr <= 0;
			prediction <= 2'b00;
		end else if(predict_valid) begin
			ghr <= {ghr[5:0], prediction[1]};
			index <= {predict_pc[6:0]} ^ {ghr[6:0]};
			prediction <= pht[index];
		end
	end
	
	// Training interface
	always @(posedge clk or posedge areset) begin
		if(areset) begin
			for (int i=0; i<128; i=i+1)
				pht[i] <= 2'b00;
		end else if(train_valid) begin
			train_pc_reg <= train_pc;
			train_taken_reg <= train_taken;
			if(train_mispredicted) begin
				pht[{train_history[6:0]} ^ {train_pc_reg[6:0]}] <= 2'b00;
				ghr <= train_history;
			end else begin
				pht[index] <= train_taken_reg ? 
					(pht[index] == 2'b11 ? 2'b11 : pht[index] + 2'b01) 
					: (pht[index] == 2'b00 ? 2'b00 : pht[index] - 2'b01);
				ghr <= {ghr[5:0], train_taken_reg};
			end
		end
	end
	
	// Prediction output
	assign predict_taken = prediction[0];
	assign predict_history = ghr;
	
endmodule
