module top_module(
	input x,
	input y,
	output z);
	
	// Declare internal wires
	wire xor_out;
	wire and_out;

	// XOR gate
	xor xgate(
		.x1(x),
		.x2(y),
		.z(xor_out)
	);

	// AND gate
	and andgate(
		.a(x),
		.b(xor_out),
		.z(and_out)
	);

	// Assign output z to the AND gate output
	assign z = and_out;

endmodule
module xor(
	input x1,
	input x2,
	output z
);
	assign z = x1 ^ x2;
endmodule
module and(
	input a,
	input b,
	output z
);
	assign z = a & b;
endmodule
