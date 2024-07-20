module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Calculate the starting index based on the selection vector (sel)
	// The starting index is the value of the selection vector (sel) multiplied by 4
	// because each block is 4 bits long
	reg [9:0] start_index = sel * 4;

	// Extract the 4-bit block from the input vector (in) using the starting index
	// and assign it to the output vector (out)
	assign out = in[start_index +: 4];

endmodule
