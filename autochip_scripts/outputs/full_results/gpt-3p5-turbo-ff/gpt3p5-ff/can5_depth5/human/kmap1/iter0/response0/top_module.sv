module top_module(
	input a, 
	input b,
	input c,
	output out
);

// Implementing the Karnaugh map logic
assign out = (~a & ~b & ~c) | (a & ~b & (c | b));

endmodule
