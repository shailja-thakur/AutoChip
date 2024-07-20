module top_module(
	input a, 
	input b,
	output out
);

	assign out = ~(a | b); // OR gate followed by inverter

endmodule
