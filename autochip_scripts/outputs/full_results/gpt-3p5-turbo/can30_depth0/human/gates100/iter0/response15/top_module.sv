module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// AND gate
	and_gate and1 (
		.in(in),
		.out(out_and)
	);

	// OR gate
	or_gate or1 (
		.in(in),
		.out(out_or)
	);

	// XOR gate
	xor_gate xor1 (
		.in(in),
		.out(out_xor)
	);

endmodule
module and_gate (
	input [99:0] in,
	output out
);

	assign out = &in;

endmodule
module or_gate (
	input [99:0] in,
	output out
);

	assign out = |in;

endmodule
module xor_gate (
	input [99:0] in,
	output out
);

	assign out = ^in;

endmodule
