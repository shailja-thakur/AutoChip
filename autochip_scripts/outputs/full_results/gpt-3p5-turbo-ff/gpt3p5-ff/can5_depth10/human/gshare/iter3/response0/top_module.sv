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
	
	// Prediction interface
	always @(posedge clk or posedge areset) begin
		if(areset)
			ghr <= 0;
		else if(predict_valid) begin
			index <= {predict_pc[6:0]} ^ {ghr[6:0]};
			prediction <= pht[index];
			ghr <= {ghr[5:0], prediction[0]};
		end
	end
	
	// Training interface
	always @(posedge clk or posedge areset) begin
		if(areset) begin
			for (int i=0; i<128; i=i+1)
				pht[i] <= 2'b0;
		end else if(train_valid) begin
			if(train_mispredicted) begin
				pht[{train_history[6:0]} ^ {train_pc[6:0]}] <= 2'b0;
				ghr <= train_history;
			end else begin
				pht[index] <= train_taken ? 
					(pht[index] == 2'b11 ? 2'b11 : pht[index] + 2'b01) 
					: (pht[index] == 2'b00 ? 2'b00 : pht[index] - 2'b01);
				ghr <= {ghr[5:0], train_taken};
			end
		end
	end
	
	// Prediction output
	assign predict_taken = prediction[1];
	assign predict_history = ghr;
	
endmodule
