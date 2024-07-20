module top_module(
	input a, 
	input b,
	output out
);
	// Use the nor gate primitive to implement NOR functionality
	nor #(1) u1(out, a, b);
endmodule
