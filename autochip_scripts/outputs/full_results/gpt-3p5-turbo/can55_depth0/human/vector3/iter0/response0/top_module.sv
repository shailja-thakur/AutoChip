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

	// Wire declaration
	wire [29:0] inputs;
	wire [31:0] outputs;

	// Concatenating input vectors
	assign inputs = {a, b, c, d, e, f};

	// Concatenating input vectors with two 1 bits in LSB positions
	assign outputs = {inputs, 2'b11};

	// Splitting up the concatenated vector into output vectors
	assign {w, x, y, z} = outputs;

endmodule
