module top_module(
	input x,
	input y,
	output z);

	// Define internal signals
	wire a1, a2, b1, b2;

	// Instantiate gates
	and_gate gate1(a1, x, y);
	and_gate gate2(a2, y, x);
	and_gate gate3(z, a1, a2);

endmodule
module and_gate(
	output z,
	input a,
	input b
);
	and z (a, b);

endmodule
