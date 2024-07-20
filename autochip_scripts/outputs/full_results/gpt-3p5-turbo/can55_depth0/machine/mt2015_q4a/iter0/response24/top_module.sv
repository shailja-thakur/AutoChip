module top_module(
	input x,
	input y,
	output z);

	// Define internal signals
	wire xor_result;
	wire and_result;

	// Implement XOR operation
	xor xor_gate(
		.x1(x),
		.x2(y),
		.z(xor_result)
	);

	// Implement AND operation
	and and_gate(
		.x1(xor_result),
		.x2(x),
		.z(and_result)
	);

	// Assign output z
	assign z = and_result;

endmodule
module xor(
	input x1,
	input x2,
	output z);

	assign z = x1 ^ x2;

endmodule
module and(
	input x1,
	input x2,
	output z);

	assign z = x1 & x2;

endmodule
