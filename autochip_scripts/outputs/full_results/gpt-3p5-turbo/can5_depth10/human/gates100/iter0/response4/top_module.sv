module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Declare signals for intermediate values
	wire [99:0] and_signal;
	wire [99:0] or_signal;
	wire [99:0] xor_signal;

	// Instantiate AND gate
	and_gate and_inst (
		.in(in),
		.out(and_signal)
	);

	// Instantiate OR gate
	or_gate or_inst (
		.in(in),
		.out(or_signal)
	);

	// Instantiate XOR gate
	xor_gate xor_inst (
		.in(in),
		.out(xor_signal)
	);

	// Assign outputs
	assign out_and = and_signal[99];
	assign out_or = or_signal[99];
	assign out_xor = xor_signal[99];

endmodule
module and_gate (
	input [99:0] in,
	output [99:0] out
);

	// Implement the AND gate
	assign out[99:0] = &in[99:0];

endmodule
module or_gate (
	input [99:0] in,
	output [99:0] out
);

	// Implement the OR gate
	assign out[99:0] = |in[99:0];

endmodule
module xor_gate (
	input [99:0] in,
	output [99:0] out
);

	// Implement the XOR gate
	assign out[99:0] = ^in[99:0];

endmodule
