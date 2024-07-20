module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

	// Implement the circuit described by the Karnaugh map
	//cd   00 01 11 10
    // ab
	assign out = (~a & ~b & c & ~d) | (~a & b & c & ~d) | (a & ~b & c & d) | (a & b & c & d) 
					| (~a & ~b & ~c & d) | (~a & b & ~c & d) | (a & ~b & ~c & d) | (a & b & ~c & d);

endmodule
