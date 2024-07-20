module top_module (
	input [7:0] in,
	output parity
);

	// Wire for storing intermediate result
	wire [7:0] xor_result;
	// Intermediate signal for XORing all input bits
	wire [6:0] xor_input;

	// Instantiate XOR gate to calculate XOR of all input bits
	xor_gate xor_inst (
		.in(xor_input),
		.out(xor_result)
	);

	// Compute XOR of all input bits
	assign xor_input = {in[7:1]};

	// Calculate parity bit (XOR of all input bits)
	assign parity = xor_result[0];

	// Instantiate XOR gate
	gate xor_gate (
		.input(xor_input),
		.output(xor_result)
	);
endmodule
module xor_gate (
	input [6:0] input,
	output [7:0] output
);
	assign output = ^input;
endmodule
