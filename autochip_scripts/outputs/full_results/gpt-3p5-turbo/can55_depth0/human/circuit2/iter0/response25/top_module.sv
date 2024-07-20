module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Your code goes here

	assign q = (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & b & ~c & ~d) | (~a & b & c & d) | (a & ~b & ~c & ~d);

endmodule
