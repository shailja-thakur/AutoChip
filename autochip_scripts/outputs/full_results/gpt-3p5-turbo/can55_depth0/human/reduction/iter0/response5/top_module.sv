module top_module (
	input [7:0] in,
	output parity
);

	// Internal wire for holding the XOR of all 8 data bits
	wire xor_output;

	// Calculate the XOR of all 8 data bits
	xor xor_gate (
		.in(in),
		.out(xor_output)
	);

	// Assign the output of the XOR gate to the parity output
	assign parity = xor_output;

endmodule
