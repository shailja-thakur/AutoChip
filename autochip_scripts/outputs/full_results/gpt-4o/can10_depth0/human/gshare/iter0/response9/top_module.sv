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
	reg [1:0] PHT [0:127];
	reg [6:0] global_history;

	integer i;

	// Asynchronous reset
	always @(posedge areset or posedge clk) begin
		if (areset) begin
			global_history <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // weakly not taken as initial state
			end
		end else begin
			if (train_valid) begin
				// Hash: XOR of PC and global history to generate index
				integer train_index = train_pc ^ train_history;
				// Update PHT entry for training
				if (train_taken && PHT[train_index] < 2'b11) begin
					PHT[train_index] <= PHT[train_index] + 1;
				end else if (!train_taken && PHT[train_index] > 2'b00) begin
					PHT[train_index] <= PHT[train_index] - 1;
				end
				// Recover global history if misprediction
				if (train_mispredicted) begin
					global_history <= train_history;
				end else begin
					// Update global history
					global_history <= {global_history[5:0], train_taken};
				end
			end else if (predict_valid) begin
				// Hash: XOR of PC and global history to generate index
				integer predict_index = predict_pc ^ global_history;
				// Output prediction
				predict_taken <= (PHT[predict_index] >= 2'b10);
				// Output current global history register value
				predict_history <= global_history;
				// Update global history for prediction
				global_history <= {global_history[5:0], predict_taken};
			end
		end
	end
endmodule
