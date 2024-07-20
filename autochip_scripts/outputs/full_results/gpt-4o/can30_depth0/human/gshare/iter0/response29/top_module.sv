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

	reg [6:0] global_history;
	reg [1:0] PHT [127:0]; // 128-entry table of two-bit saturating counters

	initial begin
		integer i;
		for (i = 0; i < 128; i = i + 1) begin
			PHT[i] = 2'b11; // Initialize to 'strongly taken' state
		end
	end

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			global_history <= 7'b0;
		end else begin
			if (train_valid && train_mispredicted) begin
				global_history <= {train_history[6:0], train_taken};
			end else if (predict_valid) begin
				global_history <= {global_history[6:0], predict_taken};
			end
		end
	end

	// Prediction logic
	always @(*) begin
		if (predict_valid) begin
			integer index;
			index = predict_pc ^ global_history;
			predict_history = global_history;
			case (PHT[index])
				2'b00: predict_taken = 0; // Strongly not taken
				2'b01: predict_taken = 0; // Weakly not taken
				2'b10: predict_taken = 1; // Weakly taken
				2'b11: predict_taken = 1; // Strongly taken
			endcase
		end else begin
			predict_taken = 0;
			predict_history = 7'b0;
		end
	end

	// Training logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			integer i;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b11; // Initialize to 'strongly taken' state
			end
		end else if (train_valid) begin
			integer index;
			index = train_pc ^ train_history;
			if (train_taken) begin
				if (PHT[index] != 2'b11) begin
					PHT[index] <= PHT[index] + 1;
				end
			end else begin
				if (PHT[index] != 2'b00) begin
					PHT[index] <= PHT[index] - 1;
				end
			end
		end
	end

endmodule
