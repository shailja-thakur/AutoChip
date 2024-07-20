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
	reg [1:0] PHT [127:0];

	integer i;
	initial begin
		for (i = 0; i < 128; i = i + 1) begin
			PHT[i] = 2'b01; // Weakly not-taken
		end
		global_history = 7'b0;
	end

	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			global_history <= 7'b0;
			for (i = 0; i < 128; i = i + 1) begin
				PHT[i] <= 2'b01; // Weakly not-taken
			end
		end else begin
			if (train_valid) begin
				// Recover global history if the branch is mispredicted
				if (train_mispredicted) begin
					global_history <= {train_history[6:1], train_taken};
				end else begin
					global_history <= {train_history[6:1], train_taken};
				end

				// Update PHT
				reg [6:0] train_index;
				train_index = train_history ^ train_pc;
				case ({PHT[train_index], train_taken})
					4'b0000, 4'b0001, 4'b0010, 4'b0011: PHT[train_index] <= 2'b00; // Strongly not-taken
					4'b0100, 4'b0101: PHT[train_index] <= 2'b01; // Weakly not-taken
					4'b0110, 4'b0111: PHT[train_index] <= 2'b10; // Weakly taken
					4'b1000, 4'b1001, 4'b1010, 4'b1011: PHT[train_index] <= 2'b00; // Overwrite to 00 for edge cases
					4'b1100, 4'b1101: PHT[train_index] <= 2'b01;                    
					4'b1110, 4'b1111: PHT[train_index] <= 2'b10;
					4'b1010: PHT[train_index] <= 2'b11; // Strongly taken
				endcase
			end else if (predict_valid) begin
				predict_history <= global_history;
				predict_taken <= (PHT[global_history ^ predict_pc] >= 2'b10);
				global_history <= {global_history[5:0], predict_taken};
			end
		end
	end

endmodule
