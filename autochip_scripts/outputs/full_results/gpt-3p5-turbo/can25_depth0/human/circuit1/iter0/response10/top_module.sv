module top_module (
	input a, 
	input b, 
	output q
);

	// Assign output q based on input a and b
	assign q = (a & !b) | (a & b);

endmodule
