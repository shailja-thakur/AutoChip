module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// Define internal wire signals
	wire [99:0] and_out;
	wire [99:0] or_out;
	wire [99:0] xor_out;

	// AND gate
	and_gate #(100) AND1 (
		.in(in),
		.out(and_out)
	);

	// OR gate
	or_gate #(100) OR1 (
		.in(in),
		.out(or_out)
	);

	// XOR gate
	xor_gate #(100) XOR1 (
		.in(in),
		.out(xor_out)
	);

	// Output assignments
	assign out_and = and_out[99];
	assign out_or = or_out[99];
	assign out_xor = xor_out[99];

endmodule
