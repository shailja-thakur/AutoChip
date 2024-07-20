module top_module(
	input x,
	input y,
	output z);

	// Intermediate wire to store the XOR result
	wire xor_result;

	// XOR gate to compute the XOR of x and y
	xor_gate xor1(
		.x(x),
		.y(y),
		.z(xor_result)
	);

	// AND gate to compute the AND of the XOR result and x
	and_gate and1(
		.x(xor_result),
		.y(x),
		.z(z)
	);

endmodule
