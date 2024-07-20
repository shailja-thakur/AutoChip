module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);

	assign outv = vec;  // Assign the vector output to be the same as the input vector
	assign o2 = vec[2]; // Assign the most significant bit to o2
	assign o1 = vec[1]; // Assign the middle bit to o1
	assign o0 = vec[0]; // Assign the least significant bit to o0

endmodule
