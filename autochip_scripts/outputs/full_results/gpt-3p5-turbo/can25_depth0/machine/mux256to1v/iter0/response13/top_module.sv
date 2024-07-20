module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Declare wire for starting index calculation
	wire [9:0] index;
	
	// Calculate starting index
	assign index = sel * 4;
	
	// Extract 4-bit block from input vector based on starting index
	assign out = in[index +: 4];
	
endmodule
