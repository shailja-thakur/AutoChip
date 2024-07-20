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

// Define the global history register
reg [6:0] global_history;

// Define the pattern history table with 128 entries of 2-bit saturating counters
reg [1:0] PHT [127:0];

// Function to hash pc and history
function [6:0] hash;
	input [6:0] pc;
	input [6:0] history;
	begin
		hash = pc ^ history; // XOR the pc and history to create the index
	end
endfunction

// Asynchronous reset
always @(posedge clk or posedge areset) begin
	if (areset) begin
		global_history <= 7'b0;
		integer i;
		for (i = 0; i < 128; i = i + 1) begin
			PHT[i] <= 2'b01; // Initialize the PHT entries to weakly not taken
		end
	end else begin
		if (train_valid) begin
			// Update the PHT based on training
			case (PHT[hash(train_pc, train_history)])
				2'b00: PHT[hash(train_pc, train_history)] <= train_taken ? 2'b01 : 2'b00;
				2'b01: PHT[hash(train_pc, train_history)] <= train_taken ? 2'b10 : 2'b00;
				2'b10: PHT[hash(train_pc, train_history)] <= train_taken ? 2'b11 : 2'b01;
				2'b11: PHT[hash(train_pc, train_history)] <= train_taken ? 2'b11 : 2'b10;
			endcase

			// Update the global history register if mispredicted
			if (train_mispredicted) begin
				global_history <= {global_history[5:0], train_taken};
			end
		end

		if (predict_valid) begin
			// Generate prediction
			predict_history <= global_history;
		end

		// Update global history register if training is not valid
		if (!train_valid && predict_valid) begin
			global_history <= {global_history[5:0], predict_taken};
		end
	end
end

// Combinational logic for generating prediction taken signal
always @(*) begin
	if (predict_valid) begin
		case (PHT[hash(predict_pc, global_history)])
			2'b00, 2'b01: predict_taken = 1'b0; // Not taken
			2'b10, 2'b11: predict_taken = 1'b1; // Taken
		endcase
	end else begin
		predict_taken = 1'b0;
	end
end

endmodule
