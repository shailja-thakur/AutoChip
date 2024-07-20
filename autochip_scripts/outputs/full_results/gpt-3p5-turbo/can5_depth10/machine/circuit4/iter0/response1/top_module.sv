module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Use 'assign' statement to assign q the logical OR operation of b and c
	assign q = b | c;

endmodule
