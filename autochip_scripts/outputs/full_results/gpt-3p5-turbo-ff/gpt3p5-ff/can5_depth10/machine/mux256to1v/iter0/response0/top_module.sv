module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
 
	// Parameter to define the width of the blocks in the input vector
	parameter BLOCK_WIDTH = 4;
	 
	reg [3:0] startIndex;
	 
	// Calculate the starting index of the selected block in the input vector
	always @* begin
		startIndex = sel * BLOCK_WIDTH;
	end
	 
	// Extract the selected block from the input vector
	always @* begin
		out = in[startIndex +: BLOCK_WIDTH];
	end
	 
endmodule
