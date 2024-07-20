module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	// Define intermediate signals
	wire b0_and_w;
	wire or_not_w;

	// The logical AND of the first bit of the input vector y and the single bit input w
	assign b0_and_w = y[0] & w;

	// The logical OR of the second, third, fifth and sixth bits of the input vector y
	wire or_of_y;
	assign or_of_y = y[1] | y[2] | y[4] | y[5];

	// The logical NOT of the single bit input w
	assign or_not_w = ~w;

	// The logical AND of the logical OR of the second, third, fifth and sixth bits of the input vector y and the logical NOT of the single bit input w
	assign Y3 = or_of_y & or_not_w;

	// Assign the outputs
	assign Y1 = b0_and_w;

endmodule
