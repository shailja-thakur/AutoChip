module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Calculate the starting index of the 4-bit block based on the selection vector
	wire [9:0] start_idx;  // Need 10 bits to represent indices from 0 to 1023
	assign start_idx = sel * 4;

	// Extract the 4-bit block from the input vector and assign it to the output vector
	assign out = in[start_idx +: 4];

endmodule
