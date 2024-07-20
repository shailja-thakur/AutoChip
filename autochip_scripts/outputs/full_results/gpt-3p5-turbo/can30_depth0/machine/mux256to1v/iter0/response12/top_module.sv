module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	
	// Calculate the starting index of the selected 4-bit block
	reg [9:0] start_index;
	always @(*)
		start_index = sel << 2;
	
	// Extract the 4-bit block from the input vector based on the starting index
	wire [3:0] selected_block = in[start_index +: 4];
	
	// Assign the selected 4-bit block to the output vector
	assign out = selected_block;
	
endmodule
