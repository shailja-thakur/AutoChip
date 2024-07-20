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

// 128-entry table of two-bit saturating counters
reg [1:0] pht [127:0];

// 7-bit global branch history register
reg [6:0] ghr;

// XOR hash function to generate 7-bit index
wire [6:0] pht_index = predict_pc ^ ghr;
wire [6:0] train_index = train_pc ^ train_history;

// initialize the PHT and GHR
integer i;
always @(posedge areset) begin
	if (areset) begin
		ghr <= 7'b0;
		for (i = 0; i < 128; i = i + 1) begin
			pht[i] <= 2'b10; // Initialize counters to weakly taken
		end
	end
end

// Predict the branch direction
always @(posedge clk or posedge areset) begin
	if (areset) begin
		predict_taken <= 0;
		predict_history <= 0;
	end else if (predict_valid) begin
		predict_history <= ghr;
		case (pht[pht_index])
			2'b00, 2'b01: predict_taken <= 0; // Not Taken
			2'b10, 2'b11: predict_taken <= 1; // Taken
		endcase
		ghr <= {ghr[5:0], predict_taken}; // Update GHR with prediction result
	end
end

// Train the branch predictor
always @(posedge clk or posedge areset) begin
	if (areset) begin
		// No action required during reset, already initialized
	end else if (train_valid) begin
		// Update PHT
		case (train_taken)
			1: begin
				if (pht[train_index] < 2'b11) begin
					pht[train_index] <= pht[train_index] + 1;
				end
			end
			0: begin
				if (pht[train_index] > 2'b00) begin
					pht[train_index] <= pht[train_index] - 1;
				end
			end
		endcase
		
		// Recover GHR if there was a misprediction
		if (train_mispredicted) begin
			ghr <= train_history;
		end else if (predict_valid && !train_mispredicted) begin
			ghr <= {ghr[5:0], predict_taken}; // Update GHR with prediction result
		end
	end
end

endmodule
