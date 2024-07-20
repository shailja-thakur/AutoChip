module top_module(
	input a, 
	input b,
	output out
);

// NOR gate implementation
assign out = ~(a | b);

endmodule
