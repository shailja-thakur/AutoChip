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
	wire [29:0] input_concat;
	assign input_concat = {a, b, c, d, e, f};

	// Split the concatenated input into output vectors
	assign {w, x, y, z} = {input_concat, 2'b11};
endmodule
