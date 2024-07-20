module top_module(
	input x,
	input y,
	output z);

	// wire declaration
	wire z;

	// XOR gate
	xor gate_xor(z, x, y);

	// AND gate
	and gate_and(z, z, x);

	// assign statement
	assign z = gate_and;

endmodule
