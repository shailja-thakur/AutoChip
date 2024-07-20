module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Declare local variables
	reg [9:0] start_index;
	reg [1023:0] selected_block;

	// Compute the starting index
	always @* begin
		start_index = sel * 4;
	end

	// Extract the selected block from the input vector
	always @* begin
		selected_block = in[start_index +: 4];
	end

	// Assign the selected block to the output
	assign out = selected_block;

endmodule
