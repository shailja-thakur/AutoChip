module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);

assign outv = vec;  	// Assign vector output to input vector
assign o2   = vec[2]; 	// Assign most significant bit
assign o1   = vec[1]; 	// Assign middle bit
assign o0   = vec[0]; 	// Assign least significant bit

endmodule
