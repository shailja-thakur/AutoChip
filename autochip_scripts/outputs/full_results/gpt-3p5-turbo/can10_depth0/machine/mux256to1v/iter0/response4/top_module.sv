module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Calculate the starting index for the 4-bit block
	reg [9:0] start_index;
	always @* begin
		start_index = sel * 4;
	end

	// Extract the 4-bit block from the input vector
	reg [3:0] out_block;
	always @* begin
		out_block = in[start_index +: 4];
	end

	// Assign the output block to the output vector
	assign out = out_block;

endmodule
