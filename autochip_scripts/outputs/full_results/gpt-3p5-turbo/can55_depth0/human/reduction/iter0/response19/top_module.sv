module top_module (
	input [7:0] in,
	output parity
);

	// Declare a wire for the XOR operation
	wire [7:0] xor_out;

	// Compute the XOR of all 8 data bits
	assign xor_out = ^in;

	// Compute the parity bit as the XOR of all 8 data bits
	assign parity = xor_out;

endmodule
