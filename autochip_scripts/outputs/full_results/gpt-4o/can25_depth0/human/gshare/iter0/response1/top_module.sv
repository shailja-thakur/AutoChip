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

	reg [1:0] PHT [0:127];       // 128-entry table of two-bit saturating counters
	reg [6:0] GHR;                // 7-bit Global History Register
	reg [6:0] train_GHR;          // Temporary GHR to handle misprediction
	
	// Saturating counter increment/decrement logic
	function [1:0] counter_update;
		input [1:0] current;
		input taken;
		begin
			case ({current, taken})
				3'b000: counter_update = 2'b00; // Strongly not taken
				3'b001: counter_update = 2'b01; // Weakly not taken
				3'b010: counter_update = 2'b00; // Weakly not taken -> Strongly not taken
				3'b011: counter_update = 2'b10; // Weakly not taken -> Weakly taken
				3'b100: counter_update = 2'b01; // Weakly taken -> Strongly not taken
				3'b101: counter_update = 2'b11; // Weakly taken -> Strongly taken
				3'b110: counter_update = 2'b10; // Weakly taken
				3'b111: counter_update = 2'b11; // Strongly taken
			endcase
		end
	endfunction

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Asynchronous reset
			GHR <= 0;
			integer i;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // Initial state: weakly not taken
			end
		end else if (train_valid) begin
			// Update the PHT based on the true branch outcome
			PHT[train_pc ^ train_history] <= counter_update(PHT[train_pc ^ train_history], train_taken);
			
			if (train_mispredicted) begin
				// Recover the GHR if there was a misprediction
				GHR <= {train_history[5:0], train_taken};
			end else begin
				// Update the GHR for the true outcome
				GHR <= {train_history[5:0], train_taken};
			end
		end else if (predict_valid) begin
			// Update GHR for the prediction
			GHR <= {GHR[5:0], predict_taken};
		end
	end

	always @(*) begin
		if (predict_valid) begin
			// Predict the branch based on the PHT entry
			predict_taken = (PHT[predict_pc ^ GHR] >= 2'b10) ? 1'b1 : 1'b0;
			predict_history = GHR;
		end else begin
			predict_taken = 1'b0;
			predict_history = GHR;
		end
	end

endmodule
