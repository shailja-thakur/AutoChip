module top_module(
	input x,
	input y,
	output z);

	// Internal wires
	wire xor_out;
	wire not_out;

	// Instantiate xor gate
	xor_gate xor_inst (
		.x(x),
		.y(y),
		.z(xor_out)
	);

	// Instantiate not gate
	not_gate not_inst (
		.in(xor_out),
		.out(not_out)
	);

	// Assign output
	assign z = not_out;

endmodule
module xor_gate(
	input x,
	input y,
	output z
);
	assign z = x ^ y;
endmodule
module not_gate(
	input in,
	output out
);
	assign out = ~in;
endmodule
