module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// Logic for output q
assign q = b | c;
endmodule
