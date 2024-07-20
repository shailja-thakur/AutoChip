module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Define the LFSR taps
	parameter TAP_1 = 5;
	parameter TAP_2 = 3;

	// Internal LFSR state
	reg [4:0] lfsr;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			lfsr <= 5'b1; // Reset the LFSR output to 1
		end else begin
			// Calculate the next LFSR value
			lfsr <= {lfsr[TAP_1-1]^lfsr[TAP_2-1], lfsr[4:1]};
		end
	end
	
	// Assign the LFSR output to the output port
	assign q = lfsr;
	
endmodule
