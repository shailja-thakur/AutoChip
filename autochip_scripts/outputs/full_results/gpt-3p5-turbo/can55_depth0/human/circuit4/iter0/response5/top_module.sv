module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Assign q based on the given truth table
	assign q = (~a & ~b & ~c & ~d) | (~a & ~b & c & ~d) | (~a & b & ~c & d) | (~a & b & c & d) | (a & ~b & ~c & d);
	
endmodule
