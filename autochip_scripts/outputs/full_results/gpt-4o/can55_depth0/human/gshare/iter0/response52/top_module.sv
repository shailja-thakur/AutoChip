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
	
	// Parameters
	parameter INDEX_BITS = 7;
	parameter PHT_SIZE = 1 << INDEX_BITS;
	parameter COUNTER_BITS = 2;
	
	// Pattern History Table (PHT)
	reg [COUNTER_BITS-1:0] pht [0:PHT_SIZE-1];
	
	// Global Branch History Register (BHR)
	reg [INDEX_BITS-1:0] bhr;
	
	// Initialize the PHT and BHR
	integer i;
	always @(posedge areset) begin
		if (areset) begin
			bhr <= 0;
			for (i = 0; i < PHT_SIZE; i = i + 1) begin
				pht[i] <= 2'b10; // Initialize to weakly taken (10)
			end
		end
	end

	// Hash function
	wire [INDEX_BITS-1:0] predict_index = predict_pc ^ bhr;
	wire [INDEX_BITS-1:0] train_index = train_pc ^ train_history;
	
	// Prediction output
	assign predict_history = bhr;
	assign predict_taken = pht[predict_index][1]; // MSB (Most Significant Bit) of the counter indicates prediction

	// Predict section (Fetch stage)
	always @(posedge clk) begin
		if (predict_valid) begin
			bhr <= {bhr[INDEX_BITS-2:0], predict_taken}; // Update BHR
		end
	end

	// Training section (Execution stage)
	always @(posedge clk) begin
		if (train_valid) begin
			// Update PHT entry
			if (train_taken) begin
				if (pht[train_index] != 2'b11) begin
					pht[train_index] <= pht[train_index] + 1; // Increase for taken
				end
			end else begin
				if (pht[train_index] != 2'b00) begin
					pht[train_index] <= pht[train_index] - 1; // Decrease for not taken
				end
			end
			
			// Recover BHR if mispredicted
			if (train_mispredicted) begin
				bhr <= {train_history[INDEX_BITS-2:0], train_taken};
			end
		end
	end

endmodule
