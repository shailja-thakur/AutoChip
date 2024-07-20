module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Calculate the starting index from the selection vector
	wire [9:0] start_index;
	assign start_index = sel * 4;

	// Extract the 4-bit block from the input vector starting from the calculated index
	assign out = in[start_index +: 4];

endmodule
