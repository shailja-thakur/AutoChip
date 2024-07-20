module top_module(
	input x,
	input y,
	output z);

	// Internal wire
	wire xor_output;

	// XOR gate
	xor_gate xor1(
		.x(x),
		.y(y),
		.z(xor_output)
	);

	// Inverter gate
	inverter inv1(
		.a(xor_output),
		.z(z)
	);

endmodule
module xor_gate(
	input x,
	input y,
	output z);

	assign z = x ^ y;

endmodule
module inverter(
	input a,
	output z);

	assign z = ~a;

endmodule
