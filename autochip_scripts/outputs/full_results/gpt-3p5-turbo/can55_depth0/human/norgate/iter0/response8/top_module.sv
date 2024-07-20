module top_module(
	input a, 
	input b,
	output out
);
	// Implement the NOR gate logic
	assign out = ~(a | b);
endmodule
