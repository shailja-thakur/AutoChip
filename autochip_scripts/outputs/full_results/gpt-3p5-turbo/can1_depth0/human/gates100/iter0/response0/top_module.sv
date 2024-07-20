module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Declare internal wire signals
	wire and_out, or_out, xor_out;

	// AND gate
	and_gate and1 (
		.in(in),
		.out(and_out)
	);

	// OR gate
	or_gate or1 (
		.in(in),
		.out(or_out)
	);

	// XOR gate
	xor_gate xor1 (
		.in(in),
		.out(xor_out)
	);

	// Assign outputs
	assign out_and = and_out;
	assign out_or = or_out;
	assign out_xor = xor_out;

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
