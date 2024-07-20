module top_module(
	input a, 
	input b,
	output out
);
	// OR gate followed by an inverter
	assign out = ~(a | b);

endmodule
