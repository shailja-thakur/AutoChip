module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Assign output q based on inputs c and d
	assign q = c | d;

endmodule
