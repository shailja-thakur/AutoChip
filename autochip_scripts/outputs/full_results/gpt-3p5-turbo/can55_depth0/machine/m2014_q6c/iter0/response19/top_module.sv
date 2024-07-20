module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	assign Y2 = y[1] & ~w;  // Y2 = logical AND of the first bit of y and the logical NOT of w
	assign Y4 = y[6] & y[5] & y[3] & y[2] & w;  // Y4 = logical AND of bits 6, 5, 3, 2 of y and w
endmodule
