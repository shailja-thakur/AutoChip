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
	reg [6:0] ghr;
	reg [6:0] pht_index;
	reg [1:0] pht_state;
	reg predict_taken;
	reg [6:0] predict_history;
	reg [6:0] train_history_temp;
	reg [6:0] train_pc_temp;

	// Prediction Logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			ghr <= 0;
			pht_index <= 0;
			pht_state <= 0;
		end else begin
			if (predict_valid) begin
				predict_taken <= pht_state[1];
				predict_history <= ghr;
			end else begin
				predict_taken <= 1;
				predict_history <= 0;
			end

			if (predict_valid) begin
				ghr <= {ghr[5:0], predict_taken};
			end
		end
	end

	// Training Logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			train_history_temp <= 0;
			train_pc_temp <= 0;
		end else begin
			if (train_valid) begin
				train_history_temp <= train_history;
				train_pc_temp <= train_pc;
			end
		end
	end
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			ghr <= 0;
			pht_index <= 0;
			pht_state <= 0;
		end else begin
			if (predict_valid) begin
				predict_taken <= pht_state[1];
				predict_history <= ghr;
			end else begin
				predict_taken <= 1;
				predict_history <= 0;
			end

			if (predict_valid) begin
				ghr <= {ghr[5:0], predict_taken};
			end
		end
	end

	// Training Logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			train_history_temp <= 0;
			train_pc_temp <= 0;
		end else begin
			if (train_valid) begin
				train_history_temp <= train_history;
				train_pc_temp <= train_pc;
			end
		end
	end

	always @(posedge clk) begin
		if (train_valid) begin
			pht_index <= train_pc_temp ^ train_history_temp;
			
			if (train_taken && train_mispredicted) begin
				pht_state[pht_index] <= pht_state[pht_index] - 1;
				ghr <= train_history_temp;
			end else begin
				pht_state[pht_index] <= pht_state[pht_index] + 1;
			end
		end
	end
endmodule
