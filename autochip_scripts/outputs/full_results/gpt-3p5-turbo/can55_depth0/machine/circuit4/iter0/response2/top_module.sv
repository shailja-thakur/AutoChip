module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Output Equation: q = b OR c
	assign q = b || c;
endmodule
