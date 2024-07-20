module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// combinational logic to derive the next-state signals Y2 and Y4
	
	assign Y2 = y[3] | y[6];
	assign Y4 = y[1] & y[2] | ~y[1] & ~y[2] & ~y[4];

endmodule
