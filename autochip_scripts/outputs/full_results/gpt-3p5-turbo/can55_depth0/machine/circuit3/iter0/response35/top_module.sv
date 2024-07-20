module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

reg q;

assign q = (a | b) & (c | d);

endmodule
