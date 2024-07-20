module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// logic gate that performs an OR operation
	assign q = b || c;
	
endmodule
