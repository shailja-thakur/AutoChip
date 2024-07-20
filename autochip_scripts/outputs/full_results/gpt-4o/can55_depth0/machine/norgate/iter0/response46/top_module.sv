module top_module(
	input a,
	input b,
	output out
);

	// Implementing the OR gate followed by an inverter
	assign out = ~(a | b);

endmodule
