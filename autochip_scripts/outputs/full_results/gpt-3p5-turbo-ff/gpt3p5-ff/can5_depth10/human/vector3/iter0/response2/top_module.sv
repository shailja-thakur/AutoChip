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
	wire [29:0] input_concatenated;
	assign input_concatenated = {f, e, d, c, b, a};

	// Split the concatenated input into output vectors
	assign {w, x, y, z, 1'b1, 1'b1} = input_concatenated;

endmodule
