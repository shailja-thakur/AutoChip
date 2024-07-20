module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Declare a wire for the starting index of the selected block
	wire [9:0] start_index;
	
	// Calculate the starting index based on the selection vector (sel)
	assign start_index = sel * 4;
	
	// Extract the 4-bit block from the input vector (in) based on the starting index
	assign out = in[start_index +: 4];
	
endmodule
