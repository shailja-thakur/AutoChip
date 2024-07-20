module top_module(
	input x,
	input y,
	output z);
	
	wire gate1_out;
	wire gate2_out;

	// First gate
	and gate1 (
		.a(x),
		.b(y),
		.z(gate1_out)
	);

	// Second gate
	or gate2 (
		.a(y),
		.b(x),
		.z(gate2_out)
	);

	// Third gate
	xor gate3 (
		.a(gate1_out),
		.b(gate2_out),
		.z(z)
	);

endmodule
