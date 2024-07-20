module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Assign output q based on inputs a, b, c, and d
	assign q = ~(a & b & c & d);

endmodule
