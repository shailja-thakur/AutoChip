module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
	assign Y1 = y[0] & w; // First bit of y AND w
	assign Y3 = (y[1] | y[2] | y[4] | y[5]) & ~w; // OR of second, third, fifth and sixth bits of y AND NOT w
endmodule
