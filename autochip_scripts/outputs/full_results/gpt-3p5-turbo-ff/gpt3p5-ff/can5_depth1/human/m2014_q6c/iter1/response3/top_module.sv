module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	// Internal signals
	wire a_next, b_next, c_next, d_next, e_next, f_next;

	// Next-state logic equations
	assign a_next = y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6] | y[1] & y[2] & y[3] & ~y[4] & ~y[5] & ~y[6];
	assign b_next = ~y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6] | y[1] & ~y[2] & ~y[3] & y[4] & ~y[5] & ~y[6];
	assign c_next = ~y[1] & y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6] | ~y[1] & ~y[2] & ~y[3] & y[4] & ~y[5] & ~y[6];
	assign d_next = ~y[1] & y[2] & ~y[3] & y[4] & ~y[5] & ~y[6] | ~y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6] | y[1] & ~y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6];
	assign e_next = ~y[1] & ~y[2] & y[3] & ~y[4] & ~y[5] & ~y[6] | ~y[1] & y[2] & ~y[3] & ~y[4] & ~y[5] & ~y[6];
	assign f_next = ~y[1] & y[2] & ~y[3] & ~y[4] & y[5] & ~y[6] | ~y[1] & ~y[2] & ~y[3] & y[4] & y[5] & ~y[6];

	// Output logic equations
	assign Y2 = a_next & ~w | b_next & y[2] & ~w | c_next & y[3] & ~w | d_next & y[4] & ~w | e_next & y[5] & ~w | f_next & y[6] & ~w;
	assign Y4 = a_next & y[3] & ~w | b_next & y[4] & ~w | c_next & d_next & y[5] & ~w | e_next & y[6] & ~w | f_next & ~y[1] & ~y[2] & ~y[4] & ~y[5] & w | f_next & y[1] & ~y[2] & ~y[3] & ~y[4] & y[5] & w;

endmodule
