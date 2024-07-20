module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Generate the starting index based on the selection vector
	reg [9:0] start_index;
	always @* begin
		start_index = sel << 2;
	end

	// Extract the 4-bit block from the input vector based on the starting index
	wire [1023:0] extracted_block;
	assign extracted_block = in[start_index +: 4];

	// Assign the extracted block to the output vector
	assign out = extracted_block[3:0];
endmodule
