module top_module(
	input x,
	input y,
	output z);

	// Declare internal signals
	wire a1, a2, b1, b2;

	// Instantiate gates
	and_gate u1(
		.a(x),
		.b(y),
		.z(a1)
	);

	and_gate u2(
		.a(y),
		.b(x),
		.z(b1)
	);

	and_gate u3(
		.a(a1),
		.b(b1),
		.z(z)
	);

endmodule
module and_gate(
	input a,
	input b,
	output z);

	assign z = a & b;

endmodule
