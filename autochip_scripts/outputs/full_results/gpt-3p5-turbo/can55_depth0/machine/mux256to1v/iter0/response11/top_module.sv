module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	
	// Calculate the starting index of the selected block
	reg [9:0] start_index;
	always @* begin
		start_index = sel * 4;
	end
	
	// Extract the 4-bit block from the input vector based on the starting index
	reg [3:0] selected_block;
	always @* begin
		selected_block = in[start_index +: 4];
	end
	
	// Assign the selected block to the output vector
	assign out = selected_block;
	
endmodule
