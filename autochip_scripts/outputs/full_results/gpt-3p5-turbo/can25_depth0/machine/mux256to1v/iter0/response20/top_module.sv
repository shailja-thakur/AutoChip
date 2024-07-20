module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Calculate index based on selection vector (sel)
	reg [9:0] index = sel << 2;
	
	// Extract 4-bit block from input vector (in) based on index
	assign out = in[index +: 4];

endmodule
