module top_module(
	input a, 
	input b,
	input c,
	output out
);

	// Instantiate the OR gates
	assign out = (a | b) & c;

endmodule
