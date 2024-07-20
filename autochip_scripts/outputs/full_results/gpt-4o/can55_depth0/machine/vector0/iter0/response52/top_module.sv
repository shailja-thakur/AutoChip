module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);

	assign outv = vec;   // Assign the 3-bit vector input to the 3-bit vector output
	assign o2 = vec[2];  // Most significant bit of the input vector
	assign o1 = vec[1];  // Middle bit of the input vector
	assign o0 = vec[0];  // Least significant bit of the input vector

endmodule
