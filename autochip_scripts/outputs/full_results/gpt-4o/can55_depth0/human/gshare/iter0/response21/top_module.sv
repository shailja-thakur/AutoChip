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

	reg [1:0] PHT [0:127];         // Pattern History Table with 128 entries of 2-bit saturating counters
	reg [6:0] global_history;      // Global History Register

	integer i;
	
	initial begin
		for (i = 0; i < 128; i = i + 1) begin
			PHT[i] = 2'b01; // Initialize all counters to weakly not taken (01)
		end
		global_history = 7'b0; // Initialize global history to 0
	end
	
	assign predict_history = global_history;

	// Predict branch direction
	wire [6:0] prediction_index = predict_pc ^ global_history;
	assign predict_taken = PHT[prediction_index][1]; // MSB of the 2-bit counter represents prediction

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset the global history and PHT
			global_history <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01;
			end
		end else begin
			if (train_valid) begin
				// Update PHT based on actual branch outcome
				reg [6:0] train_index;
				train_index = train_pc ^ train_history;
				if (train_taken) begin
					if (PHT[train_index] != 2'b11) begin
						PHT[train_index] = PHT[train_index] + 1; // Increment counter on taken
					end
				end else begin
					if (PHT[train_index] != 2'b00) begin
						PHT[train_index] = PHT[train_index] - 1; // Decrement counter on not taken
					end
				end
				
				// Update or recover global history register
				if (train_mispredicted) begin
					global_history <= train_history; // Recover to state immediately after mispredicting branch
				end else begin
					global_history <= {global_history[5:0], train_taken}; // Update global history register
				end
			end else if (predict_valid) begin
				// Update global history register based on prediction
				global_history <= {global_history[5:0], predict_taken};
			end
		end
	end

endmodule
