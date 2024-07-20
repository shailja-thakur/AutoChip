module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Calculate the starting index based on the selection vector (sel)
	// Each block is 4 bits, so multiply sel by 4 to get the starting index
	wire [9:0] start_index = sel * 4;

	// Extract the 4-bit block from the input vector (in)
	assign out = in[start_index +: 4];

endmodule
