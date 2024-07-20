module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Declare internal wire for calculating starting index
	wire [8:0] start_index;

	// Calculate starting index
	assign start_index = sel * 4;

	// Extract 4-bit block from input vector based on starting index
	assign out = in[start_index +: 4];

endmodule
