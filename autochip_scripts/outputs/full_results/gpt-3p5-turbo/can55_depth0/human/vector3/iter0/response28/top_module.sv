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

	// Declare intermediate signals
	wire [29:0] input_concat;
	wire [33:0] output_concat;

	// Concatenate input vectors and two 1 bits
	assign input_concat = {a, b, c, d, e, f, 1'b1, 1'b1};

	// Split concatenated vector into output vectors
	assign {w, x, y, z} = input_concat;

endmodule
