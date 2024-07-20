module top_module(
	input x,
	input y,
	output z
);

	// Internal wires
	wire xor_output;

	// Perform XOR operation on inputs x and y
	xor xor_gate(
		.x(x),
		.y(y),
		.z(xor_output)
	);

	// Perform logical negation of the XOR output
	not not_gate(
		.a(xor_output),
		.z(z)
	);

endmodule
module xor(
	input x,
	input y,
	output z
);
	assign z = x ^ y;
endmodule
module not(
	input a,
	output z
);
	assign z = ~a;
endmodule
