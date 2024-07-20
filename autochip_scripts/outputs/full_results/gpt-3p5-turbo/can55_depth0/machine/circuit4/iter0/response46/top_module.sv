module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Outputs q is the result of the logical OR operation between b and c
assign q = b || c;

endmodule
