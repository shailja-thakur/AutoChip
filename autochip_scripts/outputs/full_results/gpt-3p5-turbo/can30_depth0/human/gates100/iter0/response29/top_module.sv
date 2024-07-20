module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// wire for the outputs
	wire [99:0] and_out;
	wire [99:0] or_out;
	wire [99:0] xor_out;

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

	// assign outputs
	assign out_and = and_out[99];
	assign out_or = or_out[99];
	assign out_xor = xor_out[99];

endmodule
module and_gate (
	input [99:0] in,
	output [99:0] out
);

	// assign outputs
	assign out = &in;

endmodule
module or_gate (
	input [99:0] in,
	output [99:0] out
);

	// assign outputs
	assign out = |in;

endmodule
module xor_gate (
	input [99:0] in,
	output [99:0] out
);

	// assign outputs
	assign out = ^in;

endmodule
