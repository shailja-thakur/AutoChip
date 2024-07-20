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

	// Concatenation of inputs a, b, c, d, e, f, and 2'b11
	wire [35:0] concatenated;
	assign concatenated = {a, b, c, d, e, f, 2'b11};

	// Split concatenated wire into 4 outputs of 8 bits each
	assign w = concatenated[35:28];
	assign x = concatenated[27:20];
	assign y = concatenated[19:12];
	assign z = concatenated[11:4];

endmodule
