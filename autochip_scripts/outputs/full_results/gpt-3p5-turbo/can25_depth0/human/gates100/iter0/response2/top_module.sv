module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// wire for the outputs
	wire out_and_wire;
	wire out_or_wire;
	wire out_xor_wire;

	// AND gate
	and #(100) and_gate (
		.in(in),
		.out(out_and_wire)
	);

	// OR gate
	or #(100) or_gate (
		.in(in),
		.out(out_or_wire)
	);

	// XOR gate
	xor #(100) xor_gate (
		.in(in),
		.out(out_xor_wire)
	);

	// assign outputs
	assign out_and = out_and_wire;
	assign out_or = out_or_wire;
	assign out_xor = out_xor_wire;

endmodule
