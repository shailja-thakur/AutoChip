module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Register for storing the state of the LFSR
	reg [31:0] lfsr;

	// Initial value for the LFSR
	parameter INIT_VALUE = 32'h1;

	// Taps for the Galois LFSR
	parameter [4:0] TAPS = 5'b10011;

	// Output bit of the LFSR
	assign q = lfsr[31];

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			lfsr <= INIT_VALUE;
		end else begin
			// XOR the taps with the output bit to calculate the next state
			lfsr <= {lfsr[30:0], lfsr[0] ^ lfsr[21] ^ lfsr[31] ^ lfsr[31]};
		end
	end

endmodule
