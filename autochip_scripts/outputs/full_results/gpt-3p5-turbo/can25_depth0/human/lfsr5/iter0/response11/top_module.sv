module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Register to hold the LFSR state
	reg [4:0] lfsr;

	// Define the taps positions
	localparam TAP1 = 5;
	localparam TAP2 = 3;

	always @(posedge clk or posedge reset) begin
		if(reset) begin
			lfsr <= 5'b1;
		end
		else begin
			// Calculate new LFSR state
			lfsr <= {lfsr[TAP1-1] ^ lfsr[TAP2-1], lfsr[3:1]};
		end
	end

	// Assign the LFSR state to the output
	assign q = lfsr;

endmodule
