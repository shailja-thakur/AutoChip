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

	// Pattern History Table (PHT) with 128 entries of 2-bit saturating counters
	reg [1:0] PHT [127:0];
	
	// Global Branch History Register (GHR)
	reg [6:0] GHR;
	
	// Temporary register to hold next GHR value during predictions and trainings
	reg [6:0] next_GHR;

	wire [6:0] predict_index;
	wire [6:0] train_index;
	
	// Index calculation using XOR for hashing
	assign predict_index = predict_pc ^ GHR;
	assign train_index = train_pc ^ train_history;

	// Asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			integer i;
			// Reset the PHT and GHR
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // weakly not taken state
			end
			GHR <= 7'b0;
		end else begin
			if (train_valid) begin
				// Update the saturating counter in the PHT
				case (PHT[train_index])
					2'b00: PHT[train_index] <= train_taken ? 2'b01 : 2'b00;
					2'b01: PHT[train_index] <= train_taken ? 2'b10 : 2'b00;
					2'b10: PHT[train_index] <= train_taken ? 2'b11 : 2'b01;
					2'b11: PHT[train_index] <= train_taken ? 2'b11 : 2'b10;
				endcase
				
				// Update or recover the GHR based on misprediction
				if (train_mispredicted) begin
					GHR <= train_history;
				end else begin
					GHR <= next_GHR;
				end
			end else if (predict_valid) begin
				// Predict branch direction based on PHT value
				case (PHT[predict_index])
					2'b00, 2'b01: predict_taken <= 0;
					2'b10, 2'b11: predict_taken <= 1;
				endcase
				predict_history <= GHR;
				
				// Update next GHR value (shift left and insert prediction result)
				next_GHR <= {GHR[5:0], predict_taken};
			end
		end
	end

	// Sequential logic to update GHR at next clock edge
	always @(posedge clk) begin
		if (!areset && !train_valid) begin
			GHR <= next_GHR;
		end
	end
	
endmodule
