module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Parameter to define the size of the block
	parameter BLOCK_SIZE = 4;

	// Calculate the starting index of the block
	wire [9:0] start_index = sel << 2;

	// Extract the block from the input vector
	wire [BLOCK_SIZE-1:0] block = in[start_index +: BLOCK_SIZE];

	// Assign the block to the output vector
	assign out = block;

endmodule
