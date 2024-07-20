module top_module(
	input x,
	input y,
	output z);

	// Define internal signals
	wire a, b; // Signals for intermediate outputs

	// Instantiate gates
	and_gate and1(.a=x, .b=y, .z=a);
	and_gate and2(.a=y, .b=x, .z=b);
	or_gate or1(.a=a, .b=b, .z=z);

endmodule
