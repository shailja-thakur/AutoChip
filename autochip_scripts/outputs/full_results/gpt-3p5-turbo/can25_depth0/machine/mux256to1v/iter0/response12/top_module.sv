module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Parameter for the size of the block
	parameter BLOCK_SIZE = 4;
	
	always @(*)
	begin
		// Calculate the starting index for the block in the input vector
		integer startIndex;
		startIndex = sel * BLOCK_SIZE;
		
		// Extract the block from the input vector based on the starting index
		out = in[startIndex +: BLOCK_SIZE];
	end
	
endmodule
