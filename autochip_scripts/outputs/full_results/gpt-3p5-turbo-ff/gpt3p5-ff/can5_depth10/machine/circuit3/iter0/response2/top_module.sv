module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

// logic gate
assign q = (a | b) & (c | d);
endmodule
