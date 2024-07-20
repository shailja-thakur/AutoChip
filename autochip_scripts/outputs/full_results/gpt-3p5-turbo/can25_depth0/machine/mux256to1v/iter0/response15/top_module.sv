module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Find the starting index of the 4-bit block
	// in the input vector based on the selection vector
	Wire [8:0] start_index;
	assign start_index = sel * 4;
	
	// Extract the 4-bit block from the input vector
	// based on the starting index and assign it to the output vector
	assign out = in[start_index +: 4];
	
endmodule
