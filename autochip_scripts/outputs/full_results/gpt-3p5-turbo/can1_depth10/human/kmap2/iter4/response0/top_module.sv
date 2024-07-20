module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
	
	// Implementing the correct Karnaugh map
	assign out = (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (a & ~b & ~c & ~d) | (a & ~b & ~c & d) | (a & ~b & c & d);
		
endmodule
