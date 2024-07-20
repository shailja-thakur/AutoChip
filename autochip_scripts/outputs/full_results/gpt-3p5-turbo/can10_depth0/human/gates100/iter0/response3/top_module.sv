module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	// instantiate AND gate
	wire and_out;
	and gates_and (
		.in(in),
		.out(and_out)
	);

	// instantiate OR gate
	wire or_out;
	or gates_or (
		.in(in),
		.out(or_out)
	);

	// instantiate XOR gate
	wire xor_out;
	xor gates_xor (
		.in(in),
		.out(xor_out)
	);

	// assign outputs
	assign out_and = and_out;
	assign out_or = or_out;
	assign out_xor = xor_out;
endmodule
module and (
	input [99:0] in,
	output out
);

	assign out = &in;
endmodule
module or (
	input [99:0] in,
	output out
);

	assign out = |in;
endmodule
module xor (
	input [99:0] in,
	output out
);

	assign out = ^in;
endmodule
