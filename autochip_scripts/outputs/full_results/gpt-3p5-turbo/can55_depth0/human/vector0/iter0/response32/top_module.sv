module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);

	assign outv = vec; // Assign the input vector to the output vector
	assign o2 = vec[2]; // Connect position 2 of the input vector to output o2
	assign o1 = vec[1]; // Connect position 1 of the input vector to output o1
	assign o0 = vec[0]; // Connect position 0 of the input vector to output o0

endmodule
