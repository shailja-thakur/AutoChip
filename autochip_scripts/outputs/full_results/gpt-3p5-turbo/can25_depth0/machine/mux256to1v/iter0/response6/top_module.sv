module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	
	// Declare wire for starting index
	wire [9:0] start_index;
	
	// Calculate starting index using selection vector (sel)
	assign start_index = sel << 4;
	
	// Extract 4-bit block from input vector (in) starting from calculated index
	assign out = in[start_index +: 4];
	
endmodule
