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

// Define the 128-entry table of two-bit saturating counters
reg [1:0] PHT [127:0];

// Define a 7-bit global branch history register
reg [6:0] global_history;

// Hash function to create a 7-bit index using XOR
wire [6:0] index_predict = predict_pc ^ global_history;
wire [6:0] index_train = train_pc ^ train_history;

integer i;

// Reset logic
always @(posedge clk or posedge areset) begin
	if (areset) begin
		global_history <= 7'b0;
		for (i = 0; i < 128; i = i + 1) begin
			PHT[i] <= 2'b01; // Initialize all counters to weakly not taken
		end
	end else if (train_valid) begin
		// Update the PHT based on actual outcome
		case ({train_taken, PHT[index_train]})
			3'b000: PHT[index_train] <= 2'b00; // Strongly not taken stays the same
			3'b001: PHT[index_train] <= 2'b00; // Weakly not taken -> strongly not taken
			3'b010: PHT[index_train] <= 2'b01; // Weakly not taken -> weakly not taken
			3'b011: PHT[index_train] <= 2'b10; // Weakly taken -> weakly not taken
			3'b100: PHT[index_train] <= 2'b01; // Weakly not taken -> weakly taken
			3'b101: PHT[index_train] <= 2'b10; // Weakly taken -> weakly taken
			3'b110: PHT[index_train] <= 2'b11; // Weakly taken -> strongly taken
			3'b111: PHT[index_train] <= 2'b11; // Strongly taken stays the same
		endcase

		if (train_mispredicted) begin
			global_history <= train_history; // Recover branch history register
		end else begin
			global_history <= {global_history[5:0], train_taken}; // Update global history
		end
	end else if (predict_valid) begin
		global_history <= {global_history[5:0], predict_taken}; // Update global history
	end
end

// Prediction logic
always @(*) begin
	if (predict_valid) begin
		predict_history = global_history;
		predict_taken = PHT[index_predict][1]; // 1 indicates predicted taken
	end else begin
		predict_taken = 0;
		predict_history = 7'b0;
	}
end

endmodule
