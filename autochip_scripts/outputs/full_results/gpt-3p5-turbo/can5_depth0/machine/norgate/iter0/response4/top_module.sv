module top_module(
	input a, 
	input b,
	output out
);

	// OR gate
	assign or_output = a | b;
	
	// Inverter
	assign out = ~or_output;

endmodule
