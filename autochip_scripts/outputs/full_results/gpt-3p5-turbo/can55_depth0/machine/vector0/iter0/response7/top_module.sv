module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);  

// Assigning outv output to be the same as the vec input
assign outv = vec;

// Assigning o2, o1, and o0 outputs to be the same as the bits of the vec input
assign o2 = vec[2];
assign o1 = vec[1];
assign o0 = vec[0];

endmodule
