module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	assign Y2 = (y[1] & ~w) | (y[2] & ~w) | (y[6] & ~w); // Y2 is set when the state is A or B or F, and w is 0
	assign Y4 = (y[2] & ~w) | (y[3] & ~w) | (y[4] & ~w) | (y[6] & w); // Y4 is set when the state is B or C or D, and w is 0 or F and w is 1

endmodule
