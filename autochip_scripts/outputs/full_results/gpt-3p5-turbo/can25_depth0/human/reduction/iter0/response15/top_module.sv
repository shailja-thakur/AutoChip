module top_module (
	input [7:0] in,
	output parity
);

	// Internal wire declaration
	wire [7:0] xor_result;
	wire parity_bit;

	// Logic to compute XOR of all input bits
	assign xor_result = ^in;

	// Compute the final parity bit
	assign parity_bit = ^xor_result;

	// Output the result
	assign parity = parity_bit;

endmodule
