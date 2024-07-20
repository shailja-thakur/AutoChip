module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	// Implementing the Karnaugh Map
	assign out = (a & c & ~b) | (a & ~c & ~b) | (~a & ~c & b) | (c & ~b & ~d);

endmodule
