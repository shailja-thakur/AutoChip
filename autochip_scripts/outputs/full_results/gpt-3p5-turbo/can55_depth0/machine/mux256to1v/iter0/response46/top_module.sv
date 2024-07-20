module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Signal to hold the starting index calculated from sel
	reg [9:0] start_index;
	
	// Extract the starting index from sel
	always @*
		start_index = sel * 4;
	
	// Assign the selected 4-bit block to out
	assign out = in[start_index +: 4];
endmodule
