module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	parameter BIT_SIZE = 4;

	// Internal signal to store the calculated starting index
	reg [9:0] start_index;

	// Calculate the starting index based on the selection vector (sel)
	always @* begin
		start_index = sel * BIT_SIZE;
	end

	// Assign the selected 4-bit block from the input vector (in) to the output vector (out)
	assign out = in[start_index +: BIT_SIZE];

endmodule
