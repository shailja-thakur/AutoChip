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

	// 128-entry table of 2-bit saturating counters
	reg [1:0] PHT [0:127];
	reg [6:0] global_history;

	// Initial block for reset
	integer i;
	always @(posedge areset or posedge clk) begin
		if (areset) begin
			// Reset PHT entries to weakly-not-taken (2'b01) and global history 
			global_history <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01;
			end
		end else begin
			if (train_valid) begin
				// Calculate the index from train_pc and train_history
				int index = train_pc ^ train_history;

				// Update PHT entry based on train_taken
				if (train_taken) begin
					if (PHT[index] < 2'b11) begin
						PHT[index] <= PHT[index] + 1;
					end
				end else begin
					if (PHT[index] > 2'b00) begin
						PHT[index] <= PHT[index] - 1;
					end
				end

				// Update global history based on misprediction
				if (train_mispredicted) begin
					global_history <= {train_history[5:0], train_taken};
				end else begin
					global_history <= {global_history[5:0], train_taken};
				end
			end else if (predict_valid) begin
				// Update the global history for predicted branch
				global_history <= {global_history[5:0], PHT[predict_pc ^ global_history][1]};
			end
		end
	end

	always @(*) begin
		// For prediction
		if (predict_valid) begin
			// Calculate the index for prediction
			int index = predict_pc ^ global_history;
			// Output prediction result and current global history state
			predict_taken = (PHT[index] >= 2'b10); // Taken if counter >= 2
			predict_history = global_history;
		end else begin
			predict_taken = 1'b0;
			predict_history = 7'b0;
		end
	end

endmodule
