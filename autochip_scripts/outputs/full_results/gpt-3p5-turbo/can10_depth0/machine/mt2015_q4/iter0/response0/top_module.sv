module top_module(
	input a,
	input b,
	output z);

	// Instantiate gates and connections
	and_gate u1 (.a(a), .b(b), .z(z1));
	and_gate u2 (.a(b), .b(a), .z(z2));
	and_gate u3 (.a(z1), .b(z2), .z(z));

endmodule
