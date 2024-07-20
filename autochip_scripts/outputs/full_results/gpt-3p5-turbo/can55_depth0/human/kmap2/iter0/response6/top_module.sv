module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	// Implement the logic described by the Karnaugh map
	
	assign out = (~a & ~b & c) | (~a & b & d) | (a & b & ~c) | (a & ~b & c);

endmodule
