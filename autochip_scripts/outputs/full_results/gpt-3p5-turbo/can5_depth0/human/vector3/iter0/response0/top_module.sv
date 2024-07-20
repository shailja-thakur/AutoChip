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

	// Concatenate input vectors into a single signal
	wire [29:0] concat;
	assign concat = {a, b, c, d, e, f};

	// Create output vectors by splitting the concatenated signal
	assign {w, x, y, z} = {concat, 2'b11};

endmodule
