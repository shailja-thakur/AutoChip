module top_module (
	input [4:0] a,
	input [4:0] b,
	input [4:0] c,
	input [4:0] d,
	input [4:0] e,
	input [4:0] f,
	output [7:0] w,
	output [7:0] x,
	output [7:0] y,
	output [7:0] z
);

	// Concatenate the input vectors
	wire [29:0] input_concatenated = {a, b, c, d, e, f};

	// Add two 1 bits in the LSB positions
	wire [31:0] output_concatenated = {input_concatenated, 2'b11};

	// Split the concatenated output into four vectors
	assign {w, x, y, z} = output_concatenated;

endmodule
