module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

// Intermediate signals
wire y1_bit = y[0];
wire y2_3_5_6_bit = y[1] | y[2] | y[4] | y[5];

// Output assignments
assign Y1 = y1_bit & w;
assign Y3 = y2_3_5_6_bit & ~w;

endmodule
