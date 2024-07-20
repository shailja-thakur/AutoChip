module top_module(
	input a, 
	input b,
	output out
);

	// Logic gate to perform OR operation on inputs a and b
	assign or_output = a | b;

	// Inverter to invert the output of the OR gate
	assign out = ~or_output;

endmodule
