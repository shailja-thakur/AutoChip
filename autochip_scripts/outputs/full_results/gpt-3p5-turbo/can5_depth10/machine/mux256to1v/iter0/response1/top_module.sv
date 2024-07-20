module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	wire [3:0] start_idx;
	wire [1023:0] block_sel;
	
	// Calculate the starting index of the block
	assign start_idx = sel * 4;
	
	// Extract the block from the input vector
	assign block_sel = in[start_idx + 3 : start_idx];
	
	// Assign the block to the output vector
	assign out = block_sel;
	
endmodule
