module top_module(
	input a, 
	input b,
	output out
);
	// Implement a NOR gate
	assign out = ~(a | b);
endmodule
