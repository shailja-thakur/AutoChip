module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// wire declarations
	wire [3:0] startPosition;
	wire [1023:0] selectedBlock;
	
	// calculate the starting position of the 4-bit block based on the selection vector
	assign startPosition = sel << 2;
	
	// extract the 4-bit block from the input vector based on the starting position
	assign selectedBlock = in[startPosition +: 4];
	
	// assign the selected block to the output vector
	assign out = selectedBlock;
	
endmodule
