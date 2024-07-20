module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	
	// Calculate the starting index based on the selection vector
	wire [9:0] start_index;
	assign start_index = sel << 2; // Each sel value needs to multiply by 4 (shift left by 2) to get the starting index

	// Extract the 4-bit block from the input vector
	assign out = in[start_index +: 4];

endmodule
