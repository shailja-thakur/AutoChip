module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
	// Logic for the output q
	assign q = b || c;
endmodule
