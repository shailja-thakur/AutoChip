module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);

assign outv = vec; // Assign the vector output to be the same as the vector input
assign o2 = vec[2]; // Assign the most significant bit of input vector to o2
assign o1 = vec[1]; // Assign the middle bit of input vector to o1
assign o0 = vec[0]; // Assign the least significant bit of input vector to o0

endmodule
