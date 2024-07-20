module top_module (
	input a,
	input b,
	input sel,
	output out
);

	// Create the one-bit wide, 2-to-1 multiplexer
	assign out = sel ? b : a;
	
endmodule
