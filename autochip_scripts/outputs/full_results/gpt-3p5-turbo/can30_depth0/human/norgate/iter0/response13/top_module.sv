module top_module(
	input a, 
	input b,
	output out
);
	// NOR gate logic
	assign out = ~(a | b);
endmodule
