module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Declare wire and variable for the starting index of the 4-bit block
	wire [9:0] start_index;
	reg [9:0] calculated_index;
	
	// Declare variable for the extracted 4-bit block from the input vector
	reg [3:0] extracted_block;
	
	// Calculate the starting index of the 4-bit block based on the selection vector
	assign start_index = sel * 4;
	
	// Extract the 4-bit block from the input vector based on the starting index
	always @* begin
		calculated_index = start_index;
		extracted_block = in[start_index +: 4];
	end
	
	// Assign the extracted 4-bit block to the output vector
	assign out = extracted_block;

endmodule
