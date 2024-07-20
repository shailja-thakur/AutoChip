module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Calculate the starting index of the 4-bit block
	// Use the selection vector (sel) to determine the starting index
	reg [9:0] start_index;
	always @* begin
		start_index = sel * 4;        // Multiply the selection vector by 4 to get the starting index
	end
	
	// Extract the 4-bit block from the input vector
	// Use the starting index to determine the range of bits to extract
	assign out = in[start_index +: 4];

endmodule
