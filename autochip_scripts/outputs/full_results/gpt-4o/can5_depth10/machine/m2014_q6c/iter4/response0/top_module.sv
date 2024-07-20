module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

assign Y2 = y[1] & ~w;
assign Y4 = y[2] & y[3] & y[4] & y[5] & y[6] & w; // Corrected: Should include y[4] in the AND operation

endmodule
