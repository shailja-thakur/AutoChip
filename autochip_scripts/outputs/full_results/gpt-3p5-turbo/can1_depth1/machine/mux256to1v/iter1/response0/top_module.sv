module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Wire declarations
	wire [(sel + 3):0] index; // Calculation of starting index of the 4-bit block
	wire [3:0] block; // Extracted 4-bit block from the input vector
	
	// Assigning starting index of the 4-bit block
	assign index = sel << 2;

	// Extracting the 4-bit block from the input vector based on the calculated index
	assign block = in[index +: 4];

	// Assigning the extracted 4-bit block to the output vector
	assign out = block;

endmodule
