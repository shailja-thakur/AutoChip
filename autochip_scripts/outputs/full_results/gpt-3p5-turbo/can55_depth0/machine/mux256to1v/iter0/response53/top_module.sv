module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Define local variables
	reg [9:0] start_index;
	reg [3:0] selected;

	// Calculate the starting index based on the selection vector
	always @* begin
		start_index = sel * 4;
	end

	// Extract the 4-bit block from the input vector
	always @* begin
		selected = in[start_index +: 4];
	end

	// Assign the selected block to the output vector
	assign out = selected;

endmodule
