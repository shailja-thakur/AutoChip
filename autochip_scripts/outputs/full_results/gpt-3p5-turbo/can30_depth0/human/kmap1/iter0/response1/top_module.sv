module top_module(
	input a, 
	input b,
	input c,
	output out
);
	// Implementation of the Karnaugh map
	assign out = (a & b) | (b & c) | (~a & b & c);
endmodule
