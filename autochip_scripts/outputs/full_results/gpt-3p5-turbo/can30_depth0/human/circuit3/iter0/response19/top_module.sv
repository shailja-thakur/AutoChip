module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Assign statements for the output q
	assign q = (~a & ~b & ~c & ~d) | (~a & ~b & c & ~d) | (~a & b & ~c & ~d) | (~a & b & c & d) | (a & ~b & ~c & d) | (a & ~b & c & d) | (a & b & ~c & d) | (a & b & c & ~d);

endmodule
