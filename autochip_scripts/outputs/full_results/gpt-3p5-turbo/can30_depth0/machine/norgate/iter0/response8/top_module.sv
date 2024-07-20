module top_module(
	input a, 
	input b,
	output out
);

	// OR gate
	wire or_output;
	assign or_output = a | b;

	// Inverter
	assign out = ~or_output;

endmodule
