module top_module (
	input [7:0] in,
	output parity
);

	// Internal wires for intermediate signals
	wire [7:0] xor_result;
	wire parity_bit;

	// Calculate the parity bit
	assign xor_result = ^in;
	assign parity_bit = ^xor_result;

	// Assign output
	assign parity = parity_bit;

endmodule
