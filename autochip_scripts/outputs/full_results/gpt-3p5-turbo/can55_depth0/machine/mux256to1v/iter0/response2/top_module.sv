module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Calculate the starting index of the 4-bit block in the input vector
	// based on the selection vector
	reg [9:0] start_index;
	assign start_index = sel * 4;

	// Extract the 4-bit block from the input vector
	// starting from the calculated index
	always @* begin
		out[3:0] = in[start_index +: 4];
	end
endmodule
