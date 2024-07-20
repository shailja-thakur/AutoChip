module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// Assign Y1 as the AND of the first bit of y and w
	assign Y1 = y[0] & w;

	// Assign Y3 as the AND of the OR of bits 1, 2, 4, 5 of y and the NOT of w
	assign Y3 = (y[1] | y[2] | y[4] | y[5]) & ~w;

endmodule
