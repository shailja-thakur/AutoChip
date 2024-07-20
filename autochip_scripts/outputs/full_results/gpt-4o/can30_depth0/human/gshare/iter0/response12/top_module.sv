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

	// Parameters
	parameter TABLE_SIZE = 128;
	parameter HIST_LEN = 7;
	
	// Pattern History Table: 128 entries of 2-bit saturating counters
	reg [1:0] PHT [0:TABLE_SIZE-1];
	
	// Global Branch History Register
	reg [HIST_LEN-1:0] global_history;
	
	// Asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			global_history <= 7'b0;
			integer i;
			for (i = 0; i < TABLE_SIZE; i = i + 1) begin
				PHT[i] <= 2'b01; // weakly not taken state
			end
		end else begin
			if (train_valid) begin
				integer index;
				index = train_pc ^ train_history;
				
				// Update the PHT based on training
				if (train_taken) begin
					if (PHT[index] < 2'b11) begin
						PHT[index] <= PHT[index] + 1;
					end
				end else begin
					if (PHT[index] > 2'b00) begin
						PHT[index] <= PHT[index] - 1;
					end
				end
				
				// Update global history register
				if (train_mispredicted) begin
					global_history <= {train_history[HIST_LEN-2:0], train_taken};
				end else begin
					global_history <= {global_history[HIST_LEN-2:0], train_taken};
				end
			end else if (predict_valid) begin
				// Only update global history register if not training at the same time
				global_history <= {global_history[HIST_LEN-2:0], predict_taken};
			end
		end
	end
	
	// Prediction logic
	always @(*) begin
		if (predict_valid) begin
			integer index;
			index = predict_pc ^ global_history;
			case (PHT[index])
				2'b00, 2'b01: predict_taken = 0; // weakly or strongly not taken
				2'b10, 2'b11: predict_taken = 1; // weakly or strongly taken
			endcase
			predict_history = global_history;
		end else begin
			predict_taken = 0;
			predict_history = 0;
		end
	end
	
endmodule
