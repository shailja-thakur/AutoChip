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
	wire [29:0] concatenated;
	assign concatenated = {a, b, c, d, e, f};

	// Split the concatenated vector into output vectors
	assign {w, x, y, z} = {concatenated[29:22], concatenated[21:14], concatenated[13:6], concatenated[5:0]};

endmodule
