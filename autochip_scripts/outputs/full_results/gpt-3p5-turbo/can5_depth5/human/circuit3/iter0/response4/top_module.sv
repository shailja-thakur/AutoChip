module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// assign q based on the input values
	assign q = (a & b) | (c & d);

endmodule
