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
parameter PHT_SIZE = 128;
parameter COUNTER_BITS = 2;

// Two-bit saturating counter states
localparam STRONG_NOT_TAKEN = 2'b00;
localparam WEAK_NOT_TAKEN  = 2'b01;
localparam WEAK_TAKEN      = 2'b10;
localparam STRONG_TAKEN    = 2'b11;

// Pattern History Table and Global History Register
reg [COUNTER_BITS-1:0] PHT [0:PHT_SIZE-1];
reg [6:0] global_history;

// Hash function to compute index
wire [6:0] predict_index = predict_pc ^ global_history;
wire [6:0] train_index = train_pc ^ train_history;

// Predict block
always @(*) begin
	if (predict_valid) begin
		case (PHT[predict_index])
			STRONG_TAKEN, WEAK_TAKEN: predict_taken = 1;
			default: predict_taken = 0;
		endcase
	end else begin
		predict_taken = 0;
	end
	predict_history = global_history;
end

// Taken counter update
always @(posedge clk or posedge areset) begin
	if (areset) begin
		global_history <= 7'b0;
		integer i;
		for (i = 0; i < PHT_SIZE; i = i + 1) begin
			PHT[i] <= WEAK_NOT_TAKEN;
		end
	end else begin
		if (train_valid) begin
			if (train_taken) begin
				if (PHT[train_index] != STRONG_TAKEN) begin
					PHT[train_index] <= PHT[train_index] + 1;
				end
			end else begin
				if (PHT[train_index] != STRONG_NOT_TAKEN) begin
					PHT[train_index] <= PHT[train_index] - 1;
				end
			end

			// Update or recover global_history if there was a misprediction
			if (train_mispredicted) begin
				global_history <= train_history;
			end else begin
				global_history <= {global_history[5:0], train_taken};
			end
		end else if (predict_valid) begin
			global_history <= {global_history[5:0], predict_taken};
		end
	end
end

endmodule
