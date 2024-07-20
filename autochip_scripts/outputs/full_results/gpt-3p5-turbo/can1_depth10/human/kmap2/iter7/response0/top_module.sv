module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Implementing the correct Karnaugh map
	assign out = (~a & ~c & d) | (~a & ~b & ~d) | (~a & b & c) | (a & b & ~c);
		
endmodule
