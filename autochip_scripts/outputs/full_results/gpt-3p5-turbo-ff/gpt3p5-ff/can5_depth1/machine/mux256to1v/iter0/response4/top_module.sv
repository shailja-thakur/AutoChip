module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Calculate the starting index of the 4-bit block
	reg [9:0] start_index;
	always @* begin
		start_index = sel * 4;
	end
	
	// Extract the 4-bit block from the input vector
	reg [3:0] extracted_block;
	always @* begin
		extracted_block = in[start_index +: 4];
	end
	
	// Assign the extracted block to the output vector
	assign out = extracted_block;

endmodule
