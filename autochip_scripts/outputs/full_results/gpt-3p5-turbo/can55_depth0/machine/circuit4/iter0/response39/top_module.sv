module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Only b and c are used to calculate the output q
	assign q = b | c;

endmodule
