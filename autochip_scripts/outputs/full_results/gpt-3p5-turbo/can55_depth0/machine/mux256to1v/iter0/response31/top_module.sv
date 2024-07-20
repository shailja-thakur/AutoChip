module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Wire declarations
	wire [3:0] index;
	wire [1023:0] block;

	// Generate the starting index of the block
	assign index = sel * 4;

	// Extract the block from the input vector based on the index
	assign block = in[index +: 4];

	// Assign the block to the output vector
	assign out = block;

endmodule
