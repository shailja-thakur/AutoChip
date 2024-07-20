module top_module (
	input [7:0] in,
	output parity
);

	// Internal wire for computing parity bit
	wire xor_result;

	// Compute XOR of all input bits
	xor #(8) xor1 (
		.in(in),
		.out(xor_result)
	);

	// Parity bit is the output of XOR
	assign parity = xor_result;

endmodule
