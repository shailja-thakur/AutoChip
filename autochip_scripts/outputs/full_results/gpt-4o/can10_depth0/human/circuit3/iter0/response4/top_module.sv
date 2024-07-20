module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

assign q = (a & d) | (b & d) | (b & c) | (a & c);

endmodule
