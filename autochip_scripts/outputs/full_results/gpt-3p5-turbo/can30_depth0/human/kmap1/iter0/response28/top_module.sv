module top_module(
	input a, 
	input b,
	input c,
	output out
);

// Implementing the circuit described by the Karnaugh map
assign out = ((~a & ~b & c) | (a & b & c) | (a & ~b & ~c) | (a & b & ~c));

endmodule
