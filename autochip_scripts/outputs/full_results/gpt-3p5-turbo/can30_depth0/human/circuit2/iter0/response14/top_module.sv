module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Assigning the value of q based on the input values
	assign q = (a & b & ~c & ~d) | (~a & ~b & c & d) | (a & ~b & c & ~d) | (a & ~b & ~c & d) | (~a & b & ~c & d) | (~a & b & c & ~d);
	
endmodule
