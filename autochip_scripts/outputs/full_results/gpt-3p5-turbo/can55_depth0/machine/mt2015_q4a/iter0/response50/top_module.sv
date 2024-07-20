module top_module(
	input x,
	input y,
	output z);


	// Intermediate wire to store the XOR of x and y
	wire xor_result;

	// XOR gate for x and y
	xor_gate xor1(
		.x(x),
		.y(y),
		.z(xor_result)
	);

	// AND gate for xor_result and x
	and_gate and1(
		.x(xor_result),
		.y(x),
		.z(z)
	);


endmodule
module xor_gate(
	input x,
	input y,
	output z);

	assign z = x ^ y;

endmodule
module and_gate(
	input x,
	input y,
	output z);

	assign z = x & y;

endmodule
