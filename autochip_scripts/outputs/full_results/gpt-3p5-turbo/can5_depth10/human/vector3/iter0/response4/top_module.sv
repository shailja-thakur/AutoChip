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

	// Concatenate the input vectors together
	wire [29:0] concatenated_input;
	assign concatenated_input = {a, b, c, d, e, f};

	// Split the concatenated input vectors into the output vectors
	assign {w, x, y, z} = {concatenated_input[29:24], concatenated_input[23:16], concatenated_input[15:8], concatenated_input[7:0]};

	// Add two 1 bits to the LSB positions of the output
	assign {w[7:6], x[7:6], y[7:6], z[7:6]} = 2'b11;

endmodule
